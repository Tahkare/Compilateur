open CommonAST
open FlatAST
open Mips

exception Global_var
exception Local_var

let save_locals args locals = sw fp 0 sp @@ addi sp sp 8 @@
				  (if List.length args > 0 then sw a0 0 sp @@ sw a1 4 sp @@ addi sp sp 8 else nop) @@
				  (if List.length args > 1 then sw a2 0 sp @@ sw a3 4 sp @@ addi sp sp 8 else nop) @@
				  (if List.length locals > 0 then sw t2 0 sp @@ sw t3 4 sp @@ addi sp sp 8 else nop) @@
				  (if List.length locals > 1 then sw t4 0 sp @@ sw t5 4 sp @@ addi sp sp 8 else nop) @@
				  (if List.length locals > 2 then sw t6 0 sp @@ sw t7 4 sp @@ addi sp sp 8 else nop) @@
				  (if List.length locals > 3 then sw t8 0 sp @@ sw t9 4 sp @@ addi sp sp 8 else nop)
				  
let load_locals args locals = 
                  (if List.length locals > 3 then subi sp sp 8 @@ lw t8 0 sp @@ lw t9 4 sp else nop) @@
				  (if List.length locals > 2 then subi sp sp 8 @@ lw t6 0 sp @@ lw t7 4 sp else nop) @@
				  (if List.length locals > 1 then subi sp sp 8 @@ lw t4 0 sp @@ lw t5 4 sp else nop) @@
				  (if List.length locals > 0 then subi sp sp 8 @@ lw t2 0 sp @@ lw t3 4 sp else nop) @@
				  (if List.length args > 1 then subi sp sp 8 @@ lw a2 0 sp @@ lw a3 4 sp else nop) @@
				  (if List.length args > 0 then subi sp sp 8 @@ lw a0 0 sp @@ lw a1 4 sp else nop) @@
				  subi sp sp 8 @@ lw fp 0 sp

let rec remove n l = match n with
  | 0 -> l
  | _ -> remove (n-1) (List.tl l)

let find_pos s l exn =
  let rec fp_aux s l n = match l with
    | [] -> raise exn
	| (hd,_)::tl -> if hd=s then n else fp_aux s tl (n+1)
  in fp_aux s l 0
  
(* Renvoie le code pour charger la valeur éventuellement, la valeur dans r0 et son type dans r1 *)
let rec translate_value (e: FlatAST.value) recs args locals = match e with
  | Location(l) -> let code,r0,r1 = translate_location l recs args locals in if code = nop 	then (nop,r0,r1)
																							else (code @@ lw t1 0 r1 @@ lw t0 0 r0,t0,t1)

(* Renvoie le code qui permet de stocker la location dans deux registres et les registres concernés *)
and translate_location (l: FlatAST.location) recs args locals = match l with
  | Identifier(Id(s)) -> (try let m = (List.length locals) in let n = find_pos s locals Local_var
							 in (match (m-n) with
							    | 1 -> (nop,t2,t3)
								| 2 -> (nop,t4,t5)
								| 3 -> (nop,t6,t7)
								| 4 -> (nop,t8,t9)
								| _ -> let decalage = ((if recs then 8 else 0) + (max 0 (8*((List.length args)-2))) + (max 0 (8*(m-n-5)))) in (addi t0 fp decalage @@ addi t1 fp (decalage+4),t0,t1))
						 with Local_var -> (try let n = find_pos s args Global_var
												in (match n with
												   | 0 -> (nop,a0,a1)
												   | 1 -> (nop,a2,a3)
												   | _ -> let decalage = (max 0 (8*(n-2))) in (addi t0 fp decalage @@ addi t1 fp decalage,t0,t1))
											with Global_var -> (la t0 s @@ addi t1 t0 4,t0,t1)))
  | BlockAccess(v1,v2) -> 	let code1,r10,r11 = translate_value v1 recs args locals in
							let code2,r20,r21 = translate_value v2 recs args locals in
							(code2 @@ bltz r20 "atoi_error" @@ sw r20 0 sp @@ addi sp sp 8 @@ (if code1 = nop then move t0 r10 else code1 )@@ lw t0 (-4) t0 @@ srl t0 t0 16 @@ lw t1 (-8) sp @@ bge t1 t0 "atoi_error" @@ code1 @@ subi sp sp 8 @@ lw t1 0 sp @@ li s3 8 @@ mul t1 t1 s3 @@ add t0 r10 t1 @@ addi t1 t0 4,t0,t1)

(* Pour optimiser le stockage dans le registre de destination, les instructions ET les expressions sont traitées simultanément
	Cela est possible car avec la représentation trois addresses, nous n'avons plus d'expressions imbriquées *)
and translate_instruction (i : FlatAST.instruction) recs args locals = match i with
  | Nop -> 							nop
  
  | Sequence(i1,i2) -> 				let i1 = translate_instruction i1 recs args locals in 
									let i2 = translate_instruction i2 recs args locals in
									i1 @@ i2
  
  | Set(l,v) ->						let code1,r10,r11 = translate_location l recs args locals in
									let code2,r20,r21 = translate_value v recs args locals in
									comment "SetStart" @@
									if code1 = nop  then code2 @@ move r10 r20 @@ move r11 r21
													else if code2 = nop then code1 @@ sw r20 0 r10 @@ sw r21 0 r11
																		else code1 @@ move s0 r10 @@ move s1 r11 @@ code2 @@ sw r20 0 s0 @@ sw r21 0 s1
									@@ comment "SetEnd"
									
  | FlatSet(l,e) ->					let code1,r10,r11 = translate_location l recs args locals in
									comment "FlatSetStart" @@
									(match e with
									| Literal(Int(i))		->	if code1 = nop then li r10 i @@ li r11 0
																			   else code1 @@ li s0 i @@ li s1 0 @@ sw s0 0 r10 @@ sw s1 0 r11
									
									| Literal(Bool(b))		->  let i = if b then -1 else 0 in
																if code1 = nop then li r10 i @@ li r11 (-1)
																			   else code1 @@ li s0 i @@ li s1 (-1) @@ sw s0 0 r10 @@ sw s1 0 r11
									
									| UnaryOp(o,v)			->  let code2,r20,r21 = translate_value v recs args locals in
																(match o with
																| Minus	->	if code1 = nop then code2 @@ neg r10 r20 @@ li r11 0
																						   else if code2 = nop then code1 @@ neg t0 r20 @@ sw t0 0 r10 @@ sw r21 0 r11
																											   else code1 @@ move s0 r10 @@ move s1 r11 @@ code2 @@ neg t0 r20 @@ sw t0 0 s0 @@ sw r21 0 s1
																
																| Not	->  if code1 = nop then code2 @@ not_ r10 r20 @@ li r11 (-1)
																						   else if code2 = nop then code1 @@ not_ t0 r20 @@ sw t0 0 r10 @@ sw r21 0 r11
																											   else code1 @@ move s0 r10 @@ move s1 r11 @@ code2 @@ not_ t0 r20 @@ sw t0 0 s0 @@ sw r21 0 s1)
									
									| BinaryOp(o,v_1,v_2)	->  let code2,r20,r21 = translate_value v_1 recs args locals in
																let code3,r30,r31 = translate_value v_2 recs args locals in
																(match o with
																| LEq -> let code = (save_locals args locals @@ code2 @@ move a0 r20 @@ move a1 r21 @@ code3 @@ move a2 r30 @@ move a3 r31 @@ jal "logic_equality" @@ load_locals args locals) in
																		 if code1 = nop then code @@ move r10 v0 @@ move r11 v1
																						else code @@ code1 @@ sw v0 0 r10 @@ sw v1 0 r11
																		 
																		 
																| _ ->
																let op,n,b = (match o with
																			  |Add  -> add,0,false
																			  |Sub  -> sub,0,false
																			  |Mult -> mul,0,false
																			  |Div  -> div,0,false
																			  |Mod  -> rem,0,false
																			  |Eq   -> seq,(-1),true
																			  |Neq  -> sne,(-1),true
																			  |Gt   -> sgt,(-1),true
																			  |Ge   -> sge,(-1),true
																			  |Lt   -> slt,(-1),true
																			  |Le   -> sle,(-1),true
																			  |And  -> and_,(-1),false
																			  |Or   -> or_,(-1),false
																			  |_    -> failwith "Should not happen") in
																if code1 = nop then if code2 = nop then code3 @@ op r10 r20 r30 @@ (if b then neg r10 r10 else nop) @@ li r11 n
																						else if code3 = nop then code2 @@ op r10 r20 r30 @@ (if b then neg r10 r10 else nop) @@ li r11 n
																						else code2 @@ move s0 r20 @@ code3 @@ op r10 s0 r30 @@ (if b then neg r10 r10 else nop) @@ li r11 n
																			   else if code2 = nop then code1 @@ move s0 r10 @@ move s1 r11 @@ code3 @@ op t0 r20 r30 @@ (if b then neg t0 t0 else nop) @@ li t1 n @@ sw t0 0 s0 @@ sw t1 0 s1
																						else if code3 = nop then code1 @@ move s0 r10 @@ move s1 r11 @@ code2 @@ op t0 r20 r30 @@ (if b then neg t0 t0 else nop) @@ li t1 n @@ sw t0 0 s0 @@ sw t1 0 s1
																						else code1 @@ move s0 r10 @@ move s1 r11 @@ code2 @@ move s2 r20 @@ code3 @@ op t0 s2 r30 @@ (if b then neg t0 t0 else nop) @@ li t1 n @@ sw t0 0 s0 @@ sw t1 0 s1)
	
									| NewBlock(v,n)			->	let code2,r20,r21 = translate_value v recs args locals in
																let code = li v0 9 @@ save_locals args locals @@ (if code2 = nop then move t0 r20 else code2) @@ li t1 8 @@ mul a0 t0 t1 @@ addi a0 a0 4 @@ syscall @@ addi t1 v0 4 @@ sll t0 t0 16 @@ addi t0 t0 n @@ sw t0 (-4) t1 in
																if code1 = nop then code @@ load_locals args locals @@ move r10 t1 @@ li r11 1
																			   else code @@ load_locals args locals @@ move s0 t1 @@ li s1 1 @@ code1 @@ sw s0 0 r10 @@ sw s1 0 r11
									
									| LabelAddr(Lab(l))		->	if code1 = nop then la r10 l @@ li r11 (-1)
																			   else code1 @@ la s0 l @@ li s1 (-1) @@ sw s0 0 r10 @@ sw s1 0 r11
									
									| FunCall(Id(i),vl)		->	let vars_decl = List.fold_left (fun (code,cpt) value -> let next_code,r20,r21 = translate_value value recs args locals in
																											let next_code =
																												next_code @@ (match cpt with
																												| 0 -> move a0 r20 @@ move a1 r21
																												| 1 -> move a2 r20 @@ move a3 r21
																												| _ -> sw r20 0 sp @@ sw r21 4 sp @@ addi sp sp 8)
																						in (code @@ next_code,(cpt+1))) (nop,0) vl in
																let code = save_locals args locals @@ move fp sp @@ Pervasives.fst vars_decl @@ jal i @@ (let decalage = (max 0 (8*((List.length vl)-2))) in if decalage > 0 then subi sp sp decalage else nop) @@ load_locals args locals in
																if code1 = nop then code @@ move r10 v0 @@ move r11 v1
																			   else code @@ code1 @@ sw v0 0 r10 @@ sw v0 0 r11
									
									| TermFunCall(Id(i),vl)	->  let vars_decl = List.fold_left (fun (code,cpt) value -> let next_code,r20,r21 = translate_value value recs args locals in
																											let next_code =
																												next_code @@ (match cpt with
																												| 0 -> move a0 r20 @@ move a1 r21
																												| 1 -> move a2 r20 @@ move a3 r21
																												| _ -> sw r20 0 sp @@ sw r21 4 sp @@ addi sp sp 8)
																							in (code @@ next_code,(cpt+1))) (nop,0) vl in
																(let decalage = (max 0 (8*((List.length locals)-4))) in if decalage > 0 then subi sp sp decalage else nop) @@ (if recs then subi sp sp 8 @@ lw ra 0 sp @@ lw fp 4 sp else nop) @@ (let decalage = (max 0 (8*((List.length args)-2))) in if decalage > 0 then subi sp sp decalage else nop) @@ Pervasives.fst vars_decl @@ b i)
									@@ comment "FlatSetEnd"
									
  | Label(Lab(lab)) ->				label lab
  
  | Goto(Lab(lab)) ->				b lab
  
  | ConditionalGoto(Lab(lab),v) ->	let code,r0,r1 = translate_value v recs args locals in code @@ bltz r0 lab
 
  | Jump(s,l) ->					let code,r0,r1 = translate_location (Identifier(Id(s))) recs args locals  in 
									let code = (if code = nop then move s0 r0
															  else code @@ lw s0 0 r0) in
									let code2,r2,r3 = translate_location l recs args locals in
									let code2 = (if code2 = nop then move t1 r2 @@ lw t1 (-4) t1 @@ sll t1 t1 16 @@ srl t1 t1 16 @@ subi t1 t1 1
									                            else code2 @@ lw t1 0 t0 @@ lw t1 (-4) t1 @@ sll t1 t1 16 @@ srl t1 t1 16 @@ subi t1 t1 1) in
									code @@ code2 @@ li t0 8 @@ mul t1 t1 t0 @@ add t0 s0 t1 @@ lw t0 0 t0 @@ jr t0
  
  | Return(v) ->					let code1,r10,r11 = translate_value v recs args locals in
									code1 @@ move v0 r10 @@ move v1 r11 @@ (let decalage = (max 0 (8*((List.length locals)-4))) in if decalage > 0 then subi sp sp decalage else nop) @@ (if recs then subi sp sp 8 @@ lw ra 0 sp @@ lw fp 4 sp else nop) @@ jr ra
  
  | ProcCall(Id(i),vl) ->			let vars_decl = List.fold_left (fun (code,cpt) value -> let next_code,r20,r21 = translate_value value recs args locals in
																											let next_code =
																												next_code @@ (match cpt with
																												| 0 -> move a0 r20 @@ move a1 r21
																												| 1 -> move a2 r20 @@ move a3 r21
																												| _ -> sw r20 0 sp @@ sw r21 4 sp @@ addi sp sp 8)
																							in (code @@ next_code,(cpt+1))) (nop,0) vl
									in save_locals args locals @@ move fp sp @@ Pervasives.fst vars_decl @@ jal i @@ (let decalage = (max 0 (8*((List.length vl)-2))) in if decalage > 0 then subi sp sp decalage else nop) @@ load_locals args locals
  
  | TermProcCall(Id(i),vl) ->		let vars_decl = List.fold_left (fun (code,cpt) value -> let next_code,r20,r21 = translate_value value recs args locals in
																											let next_code =
																												next_code @@ (match cpt with
																												| 0 -> move a0 r20 @@ move a1 r21
																												| 1 -> move a2 r20 @@ move a3 r21
																												| _ -> sw r20 0 sp @@ sw r21 4 sp @@ addi sp sp 8)
																							in (code @@ next_code,(cpt+1))) (nop,0) vl
									in (let decalage = (max 0 (8*((List.length locals)-4))) in if decalage > 0 then subi sp sp decalage else nop) @@ (if recs then subi sp sp 8 @@ lw ra 0 sp @@ lw fp 4 sp else nop) @@ (let decalage = (max 0 (8*((List.length args)-2))) in if decalage > 0 then subi sp sp decalage else nop) @@ Pervasives.fst vars_decl @@ b i
  
  | Block(i,vl) ->					let n = (List.length locals) in
									let locals2 = vl@locals in
									let add = (let decalage = (max 0 (8*((List.length vl)-(max 0 (4-n))))) in if decalage > 0 then addi sp sp decalage else nop) in
									let i = translate_instruction i recs args locals2 in
									let n = (List.length locals2) in
									let sub = (let decalage = (max 0 (8*(min (List.length vl) (n-4)))) in if decalage > 0 then subi sp sp decalage else nop) in
									add @@ i @@ sub

let translate_program program =

  let init = 
       beqz a0 "init_end"
    @@ lw a0 0 a1
    @@ jal "atoi"
    @@ move s7 v0
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
	@@ move fp sp
	@@ move a0 s7
	@@ li a1 0
	@@ move s7 sp
	@@ jal "main_int"
	@@ li v0 10
	@@ syscall
	
  and built_ins =
       label "atoi"
	@@ move t0 a0
	@@ li t1 0
	@@ li t3 10
	@@ li t4 48
	@@ li t5 57
	@@ label "atoi_loop"
	@@ lbu t2 0 t0
	@@ beq t2 zero "atoi_end"
	@@ blt t2 t4 "atoi_error"
	@@ bgt t2 t5 "atoi_error"
	@@ addi t2 t2 (-48)
	@@ mul t1 t1 t3
	@@ add t1 t1 t2
	@@ addi t0 t0 1
	@@ b "atoi_loop"
	@@ label "atoi_error"
    @@ li   v0 10
    @@ syscall
	@@ label "atoi_end"
    @@ move v0 t1
    @@ jr   ra
	
  and predefined =
       comment "print_int"
    @@ label "print_int_int"
    @@ li v0 1
    @@ syscall
    @@ move v0 a0
	@@ li v1 0
    @@ jr ra
	
	@@ comment "power"
    @@ label "power_int_int"
    @@ move s5 a0
    @@ move s4 a2
    @@ li t0 1
    @@ b "power_loop_guard"
    @@ label "power_loop_code"
    @@ mul t0 t0 s5
    @@ subi s4 s4 1
    @@ label "power_loop_guard"
    @@ bgtz s4 "power_loop_code"
    @@ move v0 t0
	@@ li v1 0
    @@ jr ra
	
	@@ comment "print"
	@@ label "print_int"
	@@ li v0 11 
	@@ syscall
	@@ move v0 a0
	@@ li v1 0
	@@ jr ra
	
	@@ comment "scan_int"
	@@ label "scan_int"
	@@ li v0 5
	@@ syscall
	@@ li v1 0
	@@ jr ra
	
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
	@@ sw t1 0 sp
	@@ sw t2 4 sp
	@@ addi sp sp 8
	@@ jal "logic_equality"
	@@ subi sp sp 8
	@@ lw t1 0 sp
	@@ lw t2 4 sp
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
	
	and dynamic_alloc =
	   comment "malloc"
    @@ label "malloc_int"
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
	@@ sw t0 0 sp
	@@ sw t1 4 sp
	@@ sw t2 8 sp
	@@ sw t3 12 sp
	@@ sw t4 16 sp
	@@ addi sp sp 20
	@@ jal "expand_memory"
	@@ subi sp sp 20
	@@ lw t0 0 sp
	@@ lw t1 4 sp
	@@ lw t2 8 sp
	@@ lw t3 12 sp
	@@ lw t4 16 sp
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
	
	@@ comment "free"
    @@ label "free_array_of_any"
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
	
	@@ comment "sweep"
    @@ label "sweep"
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
	@@ sw t0 0 sp
	@@ sw t1 4 sp
	@@ sw t2 8 sp
	@@ sw t3 12 sp
	@@ sw t4 16 sp
	@@ addi sp sp 20
	@@ jal "free_array_of_any"
	@@ subi sp sp 20
	@@ lw t0 0 sp
	@@ lw t1 4 sp
	@@ lw t2 8 sp
	@@ lw t3 12 sp
	@@ lw t4 16 sp
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
	
	@@ comment "mark"
	@@ label "mark"
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
	@@ sw t0 0 sp
	@@ sw t1 4 sp
	@@ sw t2 8 sp
	@@ sw t3 12 sp
	@@ sw t4 16 sp
	@@ sw t5 20 sp
	@@ addi sp sp 24
	@@ lw a0 0 a0
	@@ jal "mark"
	@@ subi sp sp 24
	@@ lw t0 0 sp
	@@ lw t1 4 sp
	@@ lw t2 8 sp
	@@ lw t3 12 sp
	@@ lw t4 16 sp
	@@ lw t5 20 sp
	@@ subi sp sp 8
	@@ lw ra 0 sp
	@@ lw a0 4 sp
	@@ label "mark_loop_no"
	@@ addi a0 a0 8
	@@ addi t1 t1 1
	@@ label "mark_cond"
	@@ bne t1 t2 "mark_loop"
	@@ jr ra

    @@ comment "expand_memory"
    @@ label "expand_memory"
	@@ sw ra 0 sp
	@@ addi sp sp 4
	@@ (Symb_Tbl.fold (fun var t code -> (match t with
										 | TypInt | TypBool -> code
										 | _ -> la t0 var @@ lw a0 0 t0 @@ jal "mark" @@ code)) program.globals nop)
	@@ subi t8 s7 4
	@@ label "loop_locals"
	@@ addi t8 t8 4
	@@ lw a0 0 t8
	@@ lw t7 4 t8
	@@ subi t7 t7 1
	@@ bnez t7 "loop_locals"
	@@ jal "mark"
	@@ bne t8 sp "loop_locals"
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
	
	in
	let fun_code = Symb_Tbl.fold (fun id f code -> let args = f.signature.formals in let recs = f.recursive in let locals = Symb_Tbl.fold (fun key value l -> (key,value)::l) f.locals [] in
									let vars_decl = List.fold_left (fun (code,cpt) (key,value) -> let i = (match value with
																										  | TypInt -> 0
																										  | TypBool -> -1
																										  | _ -> 1) in
																								  let next_code = (match cpt with
																												  | 0 -> move t2 zero @@ li t0 i @@ move t3 t0
																												  | 1 -> move t4 zero @@ li t0 i @@ move t5 t0
																												  | 2 -> move t6 zero @@ li t0 i @@ move t7 t0
																												  | 3 -> move t8 zero @@ li t0 i @@ move t9 t0
																												  | _ -> sw zero 0 sp @@ li t0 i @@ sw t0 4 sp @@ addi sp sp 8) in
																								  (code @@ next_code, (cpt+1))) (nop,max 0 ((List.length args)-2)) locals in
									let fun_return = (let decalage = (max 0 (8*((List.length locals)-4))) in if decalage > 0 then subi sp sp decalage else nop) @@ (if recs then subi sp sp 8 @@ lw ra 0 sp @@ lw fp 4 sp else nop) @@ jr ra in
									label id @@ (if recs then sw ra 0 sp @@ sw fp 4 sp @@ addi sp sp 8 else nop) @@ Pervasives.fst vars_decl @@ translate_instruction f.code recs args locals @@ fun_return @@ code
					) program.functions nop in
	
	let text = init @@ predefined @@ fun_code @@ logic_equality @@ dynamic_alloc @@ built_ins in
	let data = label "__next" @@ dword[0] @@ label "__begin" @@ dword[0] @@ label "__end" @@ dword [0] @@ 
  (Symb_Tbl.fold
    (fun var t code -> let s = (match t with
								| TypInt -> 0
								| TypBool -> -1
								| _ -> 1)
					   in label var @@ dword [0] @@ label ("_type_"^var) @@ dword[s] @@ code)
    program.globals nop)
  in
  
  { text; data }
