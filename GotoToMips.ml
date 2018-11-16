open CommonAST
open GotoAST
open Mips

exception Global_var
exception Local_var

(* Fonctions auxiliaires fournissant les pseudo-instructions [push] et [pop]. 
   Ces fonctions ne sont plus utilisées 
let push reg = sw reg 0 sp  @@ subi sp sp 4
let pop  reg = addi sp sp 4 @@ lw reg 0 sp *)

let curr_function = ref []
let curr_recursive = ref false
let curr_fun_locals = ref []

let find_pos s l exn =
  let rec fp_aux s l n = match l with
    | [] -> raise exn
	| (hd,_)::tl -> if hd=s then n else fp_aux s tl (n+8)
  in fp_aux s l 0

(* Renvoie les registres 0 et 1 qui servent pour un calcul à la profondeur souhaitée *)
let get_reg nb depth =
  let sum = (nb+depth) mod 10 in match sum with
    | 0 -> t0 | 1 -> t1 | 2 -> t2
	| 3 -> t3 | 4 -> t4 | 5 -> t5
	| 6 -> t6 | 7 -> t7 | 8 -> t8
	| 9 -> t9 | _ -> failwith "n mod 10 should be between 0 and 9 for n>=0"

let save_to_stack_fun =
	sw t0 0 sp @@ sw t1 4 sp @@ sw t2 8 sp @@ sw t3 12 sp @@ sw t4 16 sp @@ sw t5 20 sp
	@@ sw t6 24 sp @@ sw t7 28 sp @@ sw t8 32 sp @@ sw t9 36 sp @@ addi sp sp 40
  
let save_to_stack depth = 
	let v = (max ((depth-8)*4) 0) in
	addi sp sp v @@ sw t0 0 sp @@ sw t1 4 sp @@ sw t2 8 sp @@ sw t3 12 sp @@ sw t4 16 sp @@ sw t5 20 sp
			  @@ sw t6 24 sp @@ sw t7 28 sp @@ sw t8 32 sp @@ sw t9 36 sp @@ addi sp sp 40
			  
let get_from_stack =
	subi sp sp 40 @@ lw t0 0 sp @@ lw t1 4 sp @@ lw t2 8 sp @@ lw t3 12 sp @@ lw t4 16 sp @@ lw t5 20 sp
			   @@ lw t6 24 sp @@ lw t7 28 sp @@ lw t8 32 sp @@ lw t9 36 sp
	
(* Raccourci syntaxique pour la traduction des opérateur binaires *)
let rec binop name e1 e2 instr depth value_type =
  translate_expr_aux name false e1 depth @@ translate_expr_aux name false e2 (depth+1) @@ instr @@ li (get_reg 1 depth) (value_type)  
  
(* Fonction récursive de traduction d'une expression. La gestion de la profondeur
  permet de décaler les calculs d'un registre pour chaque niveau de profondeur afin
  d'éviter qu'un calcul n'en écrase un autre pas terminé. Au delà d'une certaine profondeur,
  on stocke un registre dans la pile pour chaque niveau de profondeur pour le libérer pour le 
  calcul en cours et on le recharge à la fin du calcul *)  
and translate_expr_aux name terminal (e: GotoAST.expression) depth =
  let expr = (match e with
    | Literal(l) -> (match l with
      | Int(i) -> li (get_reg 0 depth) i @@ li (get_reg 1 depth) 0
      | Bool(b) -> if b then (li (get_reg 0 depth) (-1)) else (li (get_reg 0 depth) 0) @@ li (get_reg 1 depth) (-1))
    | Location(l) -> (match l with 
	  | Identifier(Id(s)) -> (try let n = find_pos s !curr_fun_locals Local_var in lw (get_reg 0 depth) (n+8*(List.length !curr_function)) fp @@ lw (get_reg 1 depth) (n+4+8*(List.length !curr_function)) fp
							  with Local_var -> (try let n = find_pos s !curr_function Global_var in (match n with 
																		| 0 -> move (get_reg 0 depth) a0 @@ move (get_reg 1 depth) a1
																		| 1 -> move (get_reg 0 depth) a2 @@ move (get_reg 1 depth) a3
																		| _ -> lw (get_reg 0 depth) n fp @@ lw (get_reg 1 depth) (n+4) fp)
							 with Global_var -> la (get_reg 1 depth) s @@ lw (get_reg 0 depth) 0 (get_reg 1 depth) @@ lw (get_reg 1 depth) 4 (get_reg 1 depth)))
	  | BlockAccess(e1,e2) -> translate_expr_aux name false e2 depth @@ bltz (get_reg 0 depth) "atoi_error" @@ translate_expr_aux name false e1 (depth+1) @@ lw (get_reg 1 depth) (-4) (get_reg 1 depth) @@ srl (get_reg 1 depth) (get_reg 1 depth) 16 @@ bge (get_reg 0 depth) (get_reg 1 depth) "atoi_error" @@ li (get_reg 1 depth) 8 @@ mul (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth) @@ translate_expr_aux name false e1 (depth+1)  @@ add (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth) @@ lw (get_reg 1 depth) 4 (get_reg 0 depth) @@ lw (get_reg 0 depth) 0 (get_reg 0 depth))
	| UnaryOp(o,e) -> translate_expr_aux name false e depth @@ (match o with
      | Minus -> neg (get_reg 0 depth) (get_reg 0 depth) @@ li (get_reg 1 depth) 0
      | Not -> not_ (get_reg 0 depth) (get_reg 0 depth) @@ li (get_reg 1 depth) (-1))
    | BinaryOp(o,e1,e2) -> (match o with
      | Add -> (match (e1,e2) with
		| Literal(Int(i1)),Literal(Int(i2)) -> li (get_reg 0 depth) i1 @@ addi (get_reg 0 depth) (get_reg 0 depth) i2 @@ li (get_reg 1 depth) 0
		| Literal(Int(i1)),_ -> translate_expr_aux name false e2 depth @@ addi (get_reg 0 depth) (get_reg 0 depth) i1 @@ li (get_reg 1 depth) 0
		| _,Literal(Int(i2)) -> translate_expr_aux name false e1 depth @@ addi (get_reg 0 depth) (get_reg 0 depth) i2 @@ li (get_reg 1 depth) 0
		| _,_ -> binop name e1 e2 (add (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth)) depth 0)
      | Sub -> (match (e1,e2) with
		| Literal(Int(i1)),Literal(Int(i2)) -> li (get_reg 0 depth) i1 @@ subi (get_reg 0 depth) (get_reg 0 depth) i2 @@ li (get_reg 1 depth) 0
		| Literal(Int(i1)),_ -> translate_expr_aux name false e2 depth @@ li (get_reg 1 depth) i1 @@ sub (get_reg 0 depth) (get_reg 1 depth) (get_reg 0 depth) @@ li (get_reg 1 depth) 0
		|_,Literal(Int(i2)) -> translate_expr_aux name false e1 depth @@ subi (get_reg 0 depth) (get_reg 0 depth) i2 @@ li (get_reg 1 depth) 0
		|_,_ -> binop name e1 e2 (sub (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth)) depth 0)
      | Mult -> binop name e1 e2 (mul (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth)) depth 0
      | Div -> binop name e1 e2 (div (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth)) depth 0
      | Mod -> binop name e1 e2 (rem (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth)) depth 0
      | Eq -> binop name e1 e2 (seq (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth) @@ neg (get_reg 0 depth) (get_reg 0 depth)) depth (-1)
      | Neq -> binop name e1 e2 (sne (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth) @@ neg (get_reg 0 depth) (get_reg 0 depth)) depth (-1)
      | Gt -> binop name e1 e2 (sgt (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth) @@ neg (get_reg 0 depth) (get_reg 0 depth)) depth (-1)
      | Ge -> binop name e1 e2 (sge (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth) @@ neg (get_reg 0 depth) (get_reg 0 depth)) depth (-1)
      | Lt -> binop name e1 e2 (slt (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth) @@ neg (get_reg 0 depth) (get_reg 0 depth)) depth (-1)
      | Le -> binop name e1 e2 (sle (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth) @@ neg (get_reg 0 depth) (get_reg 0 depth)) depth (-1)
      | And -> binop name e1 e2 (and_ (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth)) depth (-1)
      | Or -> binop name e1 e2 (or_ (get_reg 0 depth) (get_reg 0 depth) (get_reg 1 depth)) depth (-1)
	  | LEq -> translate_expr_aux name false e1 depth @@ move a0 (get_reg 0 depth) @@ move a1 (get_reg 1 depth) @@ translate_expr_aux name false e2 depth @@ move a2 (get_reg 0 depth) @@ move a3 (get_reg 1 depth) @@ save_to_stack depth @@ jal "logic_equality" @@ get_from_stack @@ move (get_reg 0 depth) v0 @@ li (get_reg 1 depth) (-1) )
	| NewBlock(e,n) -> li v0 9 @@ translate_expr_aux name false e depth @@ li (get_reg 1 depth) 8 @@ mul (get_reg 1 depth) (get_reg 0 depth) (get_reg 1 depth) @@ addi (get_reg 1 depth) (get_reg 1 depth) 4 @@ move a0 (get_reg 1 depth) @@ syscall @@ addi v0 v0 4 @@ move (get_reg 1 depth) v0 @@ sll (get_reg 0 depth) (get_reg 0 depth) 16 @@ addi (get_reg 0 depth) (get_reg 0 depth) n @@ sw (get_reg 0 depth) (-4) (get_reg 1 depth) @@ move (get_reg 0 depth) (get_reg 1 depth) @@ li (get_reg 1 depth) 1
	| LabelAddr(Lab(lab)) -> la (get_reg 0 depth) lab
	| FunCall(Id(i),el) -> let call = move fp sp @@ Pervasives.fst (List.fold_left (fun (code,n) x -> let set = (match n with
																								  | 0 -> move a0 (get_reg 0 depth) @@ move a1 (get_reg 1 depth)
																								  | 1 -> move a2 (get_reg 0 depth) @@ move a3 (get_reg 1 depth)
																								  | _ -> sw (get_reg 0 depth) 0 sp @@ sw (get_reg 1 depth) 4 sp @@ addi sp sp 8) in
									((code @@ translate_expr_aux name false x depth @@ set),(n+1))) (nop,0) el) @@ jal i in
						   let call = (if !curr_recursive then sw fp 0 sp @@ sw ra 4 sp @@ addi sp sp 8 @@ call @@ subi sp sp (max (8*((List.length el)-2)) 8) @@ lw fp 0 sp @@ lw ra 4 sp
														  else call @@ subi sp sp (max (8*((List.length el)-2)) 0))
						   in (if terminal then subi sp sp (max (8*((List.length !curr_function)-2)) 0) @@ call @@ move (get_reg 0 depth) v0 @@ move (get_reg 1 depth) v1
										   else save_to_stack depth @@ call @@ get_from_stack @@ move (get_reg 0 depth) v0 @@ move (get_reg 1 depth) v1))										  
  (* (depth-9)*4 donnera un décalage de 0 par rapport à sp à profondeur 9, 4 à 10, 8 à 11, ... *)
  in if depth > 8 then sw (get_reg 1 depth) ((depth-9)*4) sp @@ expr @@ lw (get_reg 1 depth) ((depth-9)*4) sp else expr
  
(**
   Fonction de traduction des expressions.
   [translate_expression : GotoAST.expression -> Mips.text]

   Rappel de la convention : le code généré par [translate_expression e] doit
   placer la valeur de l'expression [e] au sommet de la pile.
*)
let translate_expression name terminal (e: GotoAST.expression) = translate_expr_aux name terminal e 0	  
	  
(**
   Fonction de traduction des instructions.
   [translate_instruction : GotoAST.instruction -> Mips.text]
*)
let rec translate_instruction name (i: GotoAST.instruction) = match i with   
  | Nop -> nop
  | Sequence(i1,i2) -> translate_instruction name i1 @@ translate_instruction name i2
  | Set(l,e) -> (match l with
    | Identifier(Id(s)) ->  (try let n = find_pos s !curr_fun_locals Local_var in sw t0 (n+8*(List.length !curr_function)) fp @@ sw t1 (n+4+8*(List.length !curr_function)) fp
							with Local_var -> (try let n = find_pos s !curr_function Global_var in 
							   let m = (match n with
										| 0 -> move a0 t0 @@ move a1 t1
										| 1 -> move a2 t0 @@ move a3 t1
										| _ -> sw t0 n fp @@ sw t1 (n+4) fp) in
							   translate_expression name false e @@ m
						   with Global_var -> translate_expression name false e @@ la t2 s @@ sw t1 4 t2 @@ sw t0 0 t2))
	| BlockAccess(e1,e2) -> translate_expression name false e2 @@ move s0 t0 @@ bltz s0 "atoi_error" @@ translate_expression name false e1 @@ lw t2 (-4) t0 @@ srl t2 t2 16 @@ bge s0 t2 "atoi_error" @@ move t1 s0 @@ li t2 8 @@ mul t1 t1 t2 @@ add s0 t0 t1 @@ translate_expression name false e @@ sw t0 0 s0 @@ sw t1 4 s0)
  | Label(Lab(s)) -> label s
  | Goto(Lab(s)) -> b s
  | ConditionalGoto(Lab(s),c) -> translate_expression name false c @@ bnez t0 s
  | Jump(s,l) -> (match l with
	| Identifier(Id(t)) -> let t_access = (try let n = find_pos t !curr_fun_locals Local_var in lw t1 (n+8*(List.length !curr_function)) fp
										  with Local_var -> (try let n = find_pos t !curr_function Global_var in (match n with 
																					| 0 -> move t1 a0
																					| 1 -> move t1 a2
																					| _ -> lw t1 n fp)
										   with Global_var -> la t1 t @@ lw t1 0 t1))
						   in la t0 s @@ lw t0 0 t0 @@ t_access @@ lw t1 (-4) t1 @@ sll t1 t1 24 @@ srl t1 t1 24 @@ li t2 8 @@ mul t1 t1 t2 @@ add t0 t0 t1 @@ lw t0 0 t0 @@ jr t0
	| BlockAccess(e1,e2) -> la t0 s @@ lw t0 0 t0 @@ translate_expr_aux name false e2 1 @@ bltz t1 "atoi_error" @@ translate_expr_aux name false e1 2 @@ lw t2 (-4) t2 @@ srl t2 t2 16 @@ bge t1 t2 "atoi_error" @@ li t2 8 @@ mul t1 t1 t2 @@ translate_expr_aux name false e1 2  @@ add t1 t1 t2 @@ lw t1 0 t1 @@ lw t1 (-4) t1 @@ sll t1 t1 24 @@ srl t1 t1 24 @@ li t2 8 @@ mul t1 t1 t2 @@ add t0 t0 t1 @@ lw t0 0 t0 @@ jr t0)
  | Return(e) -> translate_expression name true e @@ move v0 t0 @@ move v1 t1 @@ subi sp sp (8*(List.length !curr_fun_locals)) @@ jr ra
  | ProcCall(Id(i),el) -> let call = move fp sp @@ Pervasives.fst (List.fold_left (fun (code,n) x -> let set = if n==0 then move a0 t0 @@ move a1 t1 else begin if n==1 then move a2 t0 @@ move a3 t1 else sw t0 0 sp @@ sw t1 4 sp @@ addi sp sp 8 end in
														((code @@ translate_expression name false x @@ set),(n+1))) (nop,0) el) @@ jal i in
						  if !curr_recursive then sw fp 0 sp @@ sw ra 4 sp @@ addi sp sp 8 @@ call @@ subi sp sp (max (8*((List.length el)-2)) 8) @@ lw fp 0 sp @@ lw ra 4 sp
											 else call @@ subi sp sp (max (8*((List.length el)-2)) 0)
(** 
    Fonction de traduction des programmes
    [translate_program : GotoAST.program -> Mips.program]

    Rien à changer dans cette fonction, elle fournit déjà l'infrastructure dans
    laquelle insérer le code principal.
*)
let translate_program program =
  (* Initialisation : lit le paramètre donné en entrée et enregistre le résultat
     dans les données statiques sous l'étiquette [arg].
     À défaut de paramètre, [arg] vaudra zéro. *)
  let init =
    beqz a0 "init_end"
    @@ lw a0 0 a1
    @@ jal "atoi"
    @@ la t0 "arg"
    @@ sw v0 0 t0
    @@ label "init_end"
	@@ li v0 9
	@@ li a0 500
	@@ syscall
	@@ la t0 "__begin"
	@@ sw v0 0 t0
	@@ la t0 "__next"
	@@ sw v0 0 t0
	@@ add v0 v0 a0
	@@ la t0 "__end"
	@@ sw v0 0 t0
	@@ jal "main_int"
      
  (* Terminaison du programme avec l'appel système [exit] *)
  and close =
       li v0 10
    @@ syscall

  (* Fonctions prédéfinies.
     En l'occurrence, fonction de lecture du paramètre d'entrée. *)
  and built_ins =
    (* Le paramètre est donné sous la forme d'une chaîne de caractères
       terminée par le caractère [000]. *)
    label "atoi"
      
    (* Variables *)
    @@ move t0 a0 (* t0 : adresse du caractère à lire *)
    @@ li   t1 0  (* t1 : accumulateur pour la valeur calculée *)
    (* On garde t2 pour des calculs intermédiaires *)
      
    (* Constantes *)
    @@ li   t3 10 (* Base décimale *)
    @@ li   t4 48 (* Code ASCII caractère '0' *)
    @@ li   t5 57 (* Code ASCII caractère '9' *)

    (* Début de la boucle de lecture *)
    @@ label "atoi_loop"
    @@ lbu  t2 0 t0 (* Lecture d'un octet *)

    (* Conditions d'arrêt et d'erreur *)
    @@ beq  t2 zero "atoi_end" (* Fin si lecture de [000] *)
    @@ blt  t2 t4 "atoi_error" (* Erreur si caractère non compris entre 0 et 9 *)
    @@ bgt  t2 t5 "atoi_error"

    (* Mise à jour de l'accumulateur *)
    @@ addi t2 t2 (-48) (* Conversion caractère en nombre *)
    @@ mul  t1 t1 t3
    @@ add  t1 t1 t2 (* t1 <- 10 * t1 + t2 *)

    (* Suite de la lecture *)
    @@ addi t0 t0 1
    @@ b "atoi_loop"

    (* Arrêt du programme en cas d'erreur de lecture *)
    @@ label "atoi_error"
    @@ li   v0 10
    @@ syscall

    (* Renvoi du résultat via [v0] en cas de succès *)
    @@ label "atoi_end"
    @@ move v0 t1
    @@ jr   ra
	
	@@ comment "print_int"
    @@ label "print_int_int"
    @@ lw s0 (-8) sp
    @@ li v0 1
    @@ syscall
    @@ move v0 s0
	@@ li v1 0
    @@ jr ra
  
    @@ comment "power"
    @@ label "power_int_int"
    @@ lw s0 (-16) sp
    @@ lw s1 (-8) sp
    @@ li t0 1
    @@ b "power_loop_guard"
    @@ label "power_loop_code"
    @@ mul t0 t0 s1
    @@ subi s0 s0 1
    @@ label "power_loop_guard"
    @@ bgtz s0 "power_loop_code"
    @@ move v0 t0
	@@ li v1 0
    @@ jr ra
	
	@@ comment "print"
	@@ label "print_int"
	@@ lw s0 (-8) sp
	@@ li v0 11 
	@@ syscall
	@@ jr ra
    
    (* Fonction qui gère l'égalité logique *)
  and logic_equality =
	   label "logic_equality"
	@@ beq a1 a3 "le_same"	(* teste si les valeurs sont de même type *)
	@@ li v0 0
	@@ jr ra
    @@ label "le_same"
	@@ bgtz a1 "le_block"	(* va à block si ce sont des pointeurs *)
	@@ beq a0 a2 "le_same_true" (* sinon, teste si les valeurs sont identiques *)
	@@ li v0 0
	@@ jr ra
	@@ label "le_same_true"
	@@ li v0 (-1)
	@@ jr ra
	@@ label "le_block"		(* block va prendre la taille de chaque tableau *)
	@@ lw t0 (-4) a0
	@@ lw t1 (-4) a2
	@@ move t2 t0
	@@ move t3 t1
	@@ srl t0 t0 16
	@@ srl t1 t1 16
	@@ sll t2 t2 24
	@@ srl t2 t2 24
	@@ sll t3 t3 24
	@@ srl t3 t3 24
	@@ beq t0 t1 "le_block_same_length"	(* teste l'égalité de taille *)
	@@ li v0 0
	@@ jr ra
	@@ label "le_block_same_length"
	@@ beq t2 t3 "le_block_same"		(* teste que ce soient bien les mêmes tags *)
	@@ li v0 0
	@@ jr ra
	@@ label "le_block_same"
	@@ li t1 0
	@@ li t2 0
	@@ label "le_block_same_loop"	(* boucle qui va parcourir les deux tableaux et rappeler à chaque fois *)
	@@ sw ra 0 sp					(* la fonction sur a[i] et b[i] *)
	@@ sw a0 4 sp
	@@ sw a2 8 sp
	@@ addi sp sp 12
	@@ add a0 a0 t2
	@@ lw a1 4 a0
	@@ lw a0 0 a0
	@@ add a2 a2 t2
	@@ lw a3 4 a2
	@@ lw a2 0 a2
	@@ save_to_stack_fun
	@@ jal "logic_equality"
	@@ get_from_stack
	@@ bnez v0 "le_bsl_end"			(* si l'appel renvoie vrai, on passe au test de boucle sinon on renvoie faux *)
	@@ li v0 0
	@@ lw ra (-12) sp
	@@ jr ra
	@@ label "le_bsl_end"
	@@ subi sp sp 12
	@@ lw ra 0 sp
	@@ lw a0 4 sp
	@@ lw a2 8 sp
	@@ addi t1 t1 1
	@@ addi t2 t2 8
	@@ bne t0 t1 "le_block_same_loop"	(* si on n'a pas fini d'itérer, on continue *)
	@@ li v0 (-1)	(* sinon on renvoie vrai *)
	@@ jr ra
	
  and expand_memory =
       label "expand_memory"
	@@ sw ra 0 sp
	@@ addi sp sp 4
	@@ (Symb_Tbl.fold (fun var t code -> (match t with
										 | TypInt | TypBool -> code
										 | _ -> la t0 var @@ lw a0 0 t0 @@ jal "mark" @@ code)) program.globals nop)
	@@ jal "sweep"
	@@ li v0 9
	@@ li a0 500
	@@ syscall
	@@ addi v0 v0 500
	@@ la t0 "__end"
	@@ sw v0 0 t0
	@@ subi sp sp 4
	@@ lw ra 0 sp
	@@ jr ra
	
  and malloc =
       label "malloc_int"
	@@ sw ra 0 sp
	@@ addi sp sp 4
	@@ li t0 8 
	@@ mul t0 a0 t0
	@@ addi t0 t0 4		(* t0 = taille à allouer *)
	@@ la t1 "__next"	
	@@ lw t2 0 t1		(* t2 = addresse du prochain bloc libre *)
	@@ label "malloc_check"		
	@@ lw t4 0 t2		(* t4 = valeur de la première case *)
	@@ la t3 "__end"
	@@ lw t3 0 t3		(* t3 = addresse de fin *)
	@@ blt t2 t3 "no_expansion" (* on regarde si on a atteint end ou pas pour appeler l'extension de mémoire *)
	@@ label "malloc_oom"
	@@ sw a0 0 sp
	@@ addi sp sp 4
	@@ save_to_stack_fun
	@@ jal "expand_memory"
	@@ get_from_stack
	@@ subi sp sp 4
	@@ lw a0 0 sp
	@@ jal "malloc_int"	(* on va rappeler l'allocation après extension pour mettre à jour la valeur de next *)
	@@ subi sp sp 4
	@@ lw ra 0 sp
	@@ jr ra
	@@ label "no_expansion"
	@@ beqz t4 "malloc_check_size"	(* si le début du bloc vaut 0, on va regarder s'il est assez grand *)
	@@ srl t4 t4 16		(* sinon, on va ajouter sa taille à next pour accéder au bloc suivant *)
	@@ li t5 8
	@@ mul t4 t4 t5
	@@ addi t4 t4 4
	@@ add t2 t2 t4
	@@ b "malloc_check"		(* puis on revérifie pour le bloc suivant *)
	@@ label "malloc_check_one" 
	@@ lw t5 0 t4
	@@ beq t5 t3 "malloc_oom" 
	@@ bnez t5 "malloc_check" (* si la case ne vaut pas zéro, c'est le début d'un bloc occupé et on appelle check pour passer au bloc suivant *)
	@@ addi t4 t4 4				(* sinon, on fait avancer les compteurs *)
	@@ subi t6 t6 4
	@@ bnez t6 "malloc_check_one"
	@@ move v0 t2
	@@ addi v0 v0 4
	@@ sw t4 0 t1
	@@ b "malloc_ok"
	@@ label "malloc_check_size" (* ici, on vérifie si un bloc vide contient assez de cases *)
	@@ move t6 t0
	@@ move t4 t2
	@@ b "malloc_check_one" (* on appelle la vérification d'une case *)
	@@ label "malloc_ok"
	@@ sll a0 a0 16 
	@@ sw a0 (-4) v0
	@@ subi sp sp 4
	@@ lw ra 0 sp
	@@ jr ra
  
  and free =
       label "free_array_of_any"
	@@ lw t0 (-4) a0	(* on prend la taille du bloc *)
	@@ srl t0 t0 16
	@@ li t1 0
	@@ sw t1 (-4) a0
	@@ move t2 a0
	@@ b "free_check"
	@@ label "free_one"	(* on va stocker 0 dans toutes les cases du tableau *)
	@@ sw t1 0 t2
	@@ sw t1 4 t2
	@@ addi t2 t2 8
	@@ subi t0 t0 1
	@@ label "free_check"
	@@ bnez t0 "free_one"
	@@ la t1 "__next"
	@@ lw t0 0 t1
	@@ slt t2 a0 t0		(* si l'addresse du bloc est inférieure à next, next prend sa valeur *)
	@@ beqz t2 "free_end" 
	@@ sw a0 0 t1
	@@ label "free_end"
	@@ jr ra
  
  and mark = (* if mark=0 then mark=1, iterate over the array and call mark for every pointer *)
	   label "mark"
	@@ lw t0 (-4) a0	(* on récupère la taille de l'array *)
	@@ srl t2 t0 16		(* t2 = taille *)
	@@ sll t1 t0 16		(* t1 = marked *)
	@@ srl t1 t1 24
	@@ bnez t1 "marked"	(* si le bloc n'est pas marqué, on le marque *)
	@@ addi t0 t0 256
	@@ sw t0 (-4) a0
	@@ label "marked"
	@@ li t1 0			(* t1 = compteur *)
	@@ b "mark_cond"
	@@ label "mark_loop"			(* on itère sur le bloc pour appeler récursivement mark sur *)
	@@ lw t3 0 a0					(* les valeurs de pointeurs *) 
	@@ lw t4 4 a0
	@@ li t5 1
	@@ bne t4 t5 "mark_loop_no"		(* si n'est pas un array, on passe cette partie de la boucle *)
	@@ sw ra 0 sp
	@@ sw a0 4 sp
	@@ addi sp sp 8
	@@ save_to_stack_fun
	@@ lw a0 0 a0
	@@ jal "mark"
	@@ get_from_stack
	@@ subi sp sp 8
	@@ lw ra 0 sp
	@@ lw a0 4 sp
	@@ label "mark_loop_no"
	@@ addi a0 a0 8
	@@ addi t1 t1 1
	@@ label "mark_cond"
	@@ bne t1 t2 "mark_loop"
	@@ jr ra
	
  and sweep = (* start at the beginning of the heap, if 0 advance, else if not 0 and !marked, set all array to 0 else go to next*)
       label "sweep"
	@@ la t0 "__begin"
	@@ lw t0 0 t0	(* t0 = addresse actuelle du sweep *)
	@@ la t1 "__end"
	@@ lw t1 0 t1	(* t1 = addresse de fin *)
	@@ b "sweep_cond"
	@@ label "sweep_loop"
	@@ lw t2 0 t0 (* t2 = value de la case actuelle *)
	@@ bnez t2 "sweep_not_zero"	(* si la case vaut zéro, on va à la case suivante sinon, on va à la partie qui gère le sweep d'un tableau *)
	@@ addi t0 t0 4
	@@ b "sweep_cond"
	@@ label "sweep_not_zero"
	@@ srl t3 t2 16 (* t3 = taille de l'array *)
	@@ sll t2 t2 16
	@@ srl t2 t2 24 (* t2 = marked *)
	@@ bnez t2 "sweep_goto_next" (* si le tableau est marqué, on va au suivant sinon on va appeler free *)
	@@ addi a0 t0 4
	@@ save_to_stack_fun
	@@ jal "free_array_of_any"
	@@ get_from_stack
	@@ b "sweep_cond"
	@@ label "sweep_goto_next"	(* on prend la taille du tableau et on l'ajoute à l'addresse dans t0 *)
	@@ lw t2 0 t0
	@@ subi t2 t2 256 (* on enlève le marquage *)
	@@ sw t2 0 t0
	@@ li t4 8
	@@ mul t3 t3 t4
	@@ addi t3 t3 4
	@@ add t0 t0 t3
	@@ label "sweep_cond"
	@@ blt t0 t1 "sweep_loop"
	@@ jr ra
  	
  in
  (* Construction du texte du programme *)
  let fun_code = Symb_Tbl.fold (fun id f code -> curr_function := f.signature.formals; curr_recursive := f.recursive; curr_fun_locals := Symb_Tbl.fold (fun key value l -> (key,value)::l) f.locals [];
							   (List.fold_left (fun code (key,value) -> code @@ (match value with
																		| TypInt -> sw zero 0 sp @@ sw zero 4 sp @@ addi sp sp 8
																		| TypBool -> sw zero 0 sp @@ li t0 (-1) @@ sw t0 4 sp @@ addi sp sp 8
																		| _ -> sw zero 0 sp @@ li t0 1 @@ sw t0 4 sp @@ addi sp sp 8)) nop !curr_fun_locals)
							   @@ label id @@ translate_instruction id GotoAST.(f.code) @@ subi sp sp (8*(List.length !curr_fun_locals)) @@ jr ra @@ code) program.functions nop in
  let text = init @@ close @@ fun_code @@ logic_equality @@ 
			 expand_memory @@ malloc @@ free @@ mark @@ sweep @@ 
			 built_ins in

  (* Initialisation de la partie des données statiques *)
  let data = label "__next" @@ dword[0] @@ label "__begin" @@ dword[0] @@ label "__end" @@ dword [0] @@ 
  (Symb_Tbl.fold
    (fun var t code -> let s = (match t with
								| TypInt -> 0
								| TypBool -> -1
								| _ -> 1)
					   in label var @@ dword [0] @@ label ("_type_"^var) @@ dword[s] @@ code)
    program.globals nop)
  in

  (* Programme généré *)
  { text; data }
