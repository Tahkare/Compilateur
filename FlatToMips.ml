open CommonAST
open FlatAST
open Mips

exception Global_var
exception Local_var

let save_locals args locals = (if List.length args > 0 then sw a0 0 sp @@ sw a1 4 sp @@ addi sp sp 8 else nop) @@
				  (if List.length args > 1 then sw a2 0 sp @@ sw a3 4 sp @@ addi sp sp 8 else nop) @@
				  (if List.length locals > 0 then sw t2 0 sp @@ sw t3 4 sp @@ addi sp sp 8 else nop) @@
				  (if List.length locals > 1 then sw t4 0 sp @@ sw t5 4 sp @@ addi sp sp 8 else nop) @@
				  (if List.length locals > 2 then sw t6 0 sp @@ sw t7 4 sp @@ addi sp sp 8 else nop) @@
				  (if List.length locals > 3 then sw t8 0 sp @@ sw t9 4 sp @@ addi sp sp 8 else nop)
				  
let load_locals args locals = (if List.length locals > 3 then subi sp sp 8 @@ lw t8 0 sp @@ lw t9 4 sp else nop) @@
				  (if List.length locals > 2 then subi sp sp 8 @@ lw t6 0 sp @@ lw t7 4 sp else nop) @@
				  (if List.length locals > 1 then subi sp sp 8 @@ lw t4 0 sp @@ lw t5 4 sp else nop) @@
				  (if List.length locals > 0 then subi sp sp 8 @@ lw t2 0 sp @@ lw t3 4 sp else nop) @@
				  (if List.length args > 1 then subi sp sp 8 @@ lw a2 0 sp @@ lw a3 4 sp else nop) @@
				  (if List.length args > 0 then subi sp sp 8 @@ lw a0 0 sp @@ lw a1 4 sp else nop)

let rec remove n l = match n with
  | 0 -> l
  | _ -> remove (n-1) (List.tl l)

let find_pos s l exn =
  let rec fp_aux s l n = match l with
    | [] -> raise exn
	| (hd,_)::tl -> if hd=s then n else fp_aux s tl (n+1)
  in fp_aux s l 0
  
(* Renvoie la valeur dans t0 et son type dans t1 *)
let rec translate_value (e: FlatAST.value) recs args locals = match e with
  | Location(l) -> let code,r0,r1 = translate_location l recs args locals in if code = nop 	then move t1 r1 @@ move t0 r0
																							else code @@ lw t1 0 r1 @@ lw t0 0 r0

(* Renvoie la valeur de l'expression dans t0 et son type dans t1 *)
and translate_expression (e: FlatAST.expression) recs args locals = match e with
  | Literal(Int(i)) -> 			li t0 i @@ li t1 0
  | Literal(Bool(b)) ->			let b = if b then (-1) else 0 in li t0 b @@ li t1 (-1)
  | UnaryOp(o,v) -> 			(match o with
									| Minus -> 	translate_value v recs args locals @@ neg t0 t0 @@ li t1 0
									| Not ->	translate_value v recs args locals @@ not_ t0 t0 @@ li t1 (-1))
  | BinaryOp(o,v1,v2) ->		let c1 = translate_value v1 recs args locals in
								let c2 = translate_value v2 recs args locals in
								let code = c1 @@ move s0 t0 @@ c2 @@ move t1 s0 in
								(match o with
									| Add -> code @@ add t0 t1 t0 @@ li t1 0
									| Sub -> code @@ sub t0 t1 t0 @@ li t1 0
									| Mult -> code @@ mul t0 t1 t0 @@ li t1 0
									| Div -> code @@ div t0 t1 t0 @@ li t1 0
									| Mod -> code @@ rem t0 t1 t0 @@ li t1 0
									| Eq -> code @@ seq t0 t1 t0 @@ neg t0 t0 @@ li t1 (-1)
									| Neq -> code @@ sne t0 t1 t0 @@ neg t0 t0 @@ li t1 (-1)
									| Gt -> code @@ sgt t0 t1 t0 @@ neg t0 t0 @@ li t1 (-1)
									| Ge -> code @@ sge t0 t1 t0 @@ neg t0 t0 @@ li t1 (-1)
									| Lt -> code @@ slt t0 t1 t0 @@ neg t0 t0 @@ li t1 (-1)
									| Le -> code @@ sle t0 t1 t0 @@ neg t0 t0 @@ li t1 (-1)
									| And -> code @@ and_ t0 t1 t0 @@ li t1 (-1)
									| Or -> code @@ or_ t0 t1 t0 @@ li t1 (-1)
									| LEq -> c1 @@ move a0 t0 @@ move a1 t1 @@ c2 @@ move a2 t0 @@ move a3 t1 @@ save_locals args locals @@ jal "logic_equality" @@ load_locals args locals @@ move t0 v0 @@ li t1 (-1))
  | NewBlock(v,n) ->			li v0 9 @@ translate_value v recs args locals @@ li t1 8 @@ mul a0 t0 t1 @@ addi a0 a0 4 @@ syscall @@ addi t1 v0 4 @@ sll t0 t0 16 @@ addi t0 t0 n @@ sw t0 (-4) t1 @@ move t0 t1 @@ li t1 1
  | LabelAddr(Lab(lab)) -> 		la t0 lab
  | FunCall(Id(i),vl) -> 		let vars_decl = List.fold_left (fun (code,cpt) value -> let next_code = translate_value value recs args locals @@ (match cpt with
																											| 0 -> move a0 t0 @@ move a1 t1
																											| 1 -> move a2 t0 @@ move a3 t1
																											| _ -> sw t0 0 sp @@ sw t1 4 sp @@ addi sp sp 8)
																						in (code @@ next_code,(cpt+1))) (nop,0) vl
								in save_locals args locals @@ move fp sp @@ Pervasives.fst vars_decl @@ jal i @@ (let decalage = (max 0 (8*((List.length vl)-2))) in if decalage > 0 then subi sp sp decalage else nop) @@ load_locals args locals @@ move t0 v0 @@ move t1 v1
  | TermFunCall(Id(i),vl) -> 	let vars_decl = List.fold_left (fun (code,cpt) value -> let next_code = translate_value value recs args locals  @@ (match cpt with
																											| 0 -> move a0 t0 @@ move a1 t1
																											| 1 -> move a2 t0 @@ move a3 t1
																											| _ -> sw t0 0 sp @@ sw t1 4 sp @@ addi sp sp 8)
																							in (code @@ next_code,(cpt+1))) (nop,0) vl
								in (let decalage = (max 0 (8*((List.length locals)-4))) in if decalage > 0 then subi sp sp decalage else nop) @@ (if recs then subi sp sp 8 @@ lw ra 0 sp @@ lw fp 4 sp else nop) @@ (let decalage = (max 0 (8*((List.length args)-2))) in if decalage > 0 then subi sp sp decalage else nop) @@ Pervasives.fst vars_decl @@ b i

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
  | BlockAccess(v1,v2) -> (translate_value v2 recs args locals @@ lw t1 0 t0 @@ bltz t0 "atoi_error" @@ translate_value v1 recs args locals @@ lw t0 0 t0 @@ lw t0 (-4) t0 @@ srl t0 t0 16 @@ bge t1 t0 "atoi_error" @@ li t0 8 @@ mul t1 t1 t0 @@ translate_value v1 recs args locals @@ lw t0 0 t0 @@ add t0 t0 t1 @@ addi t1 t0 4,t0,t1)
							
and translate_instruction (i : FlatAST.instruction) recs args locals = match i with
  | Nop -> 							nop
  | Sequence(i1,i2) -> 				let i1 = translate_instruction i1 recs args locals in 
									let i2 = translate_instruction i2 recs args locals in
									i1 @@ i2
  | Set(l,v) ->						let code,r0,r1 = translate_location l recs args locals in if code = nop then translate_value v recs args locals @@ move r0 t0 @@ move r1 t1
																											else translate_value v recs args locals @@ move s0 t0 @@ move s1 t1 @@ code @@ sw s0 0 r0 @@ sw s1 0 r1
  | FlatSet(l,e) ->					let code,r0,r1 = translate_location l recs args locals in if code = nop then translate_expression e recs args locals @@ move r0 t0 @@ move r1 t1
																											else translate_expression e recs args locals @@ move s0 t0 @@ move s1 t1 @@ code @@ sw s0 0 r0 @@ sw s1 0 r1
  | Label(Lab(lab)) ->				label lab
  | Goto(Lab(lab)) ->				b lab
  | ConditionalGoto(Lab(lab),v) ->	translate_value v recs args locals @@ bltz t0 lab
  | Jump(s,l) ->					(* todo *) nop
  | Return(v) ->					translate_value v recs args locals @@ move v0 t0 @@ move v1 t1 @@ (let decalage = (max 0 (8*((List.length locals)-4))) in if decalage > 0 then subi sp sp decalage else nop) @@ (if recs then subi sp sp 8 @@ lw ra 0 sp @@ lw fp 4 sp else nop) @@ jr ra
  | ProcCall(Id(i),vl) ->			let vars_decl = List.fold_left (fun (code,cpt) value -> let next_code = translate_value value recs args locals @@ (match cpt with
																											| 0 -> move a0 t0 @@ move a1 t1
																											| 1 -> move a2 t0 @@ move a3 t1
																											| _ -> sw t0 0 sp @@ sw t1 4 sp @@ addi sp sp 8)
																							in (code @@ next_code,(cpt+1))) (nop,0) vl
									in save_locals args locals @@ move fp sp @@ Pervasives.fst vars_decl @@ jal i @@ (let decalage = (max 0 (8*((List.length vl)-2))) in if decalage > 0 then subi sp sp decalage else nop) @@ load_locals args locals
  | TermProcCall(Id(i),vl) ->		let vars_decl = List.fold_left (fun (code,cpt) value -> let next_code = translate_value value recs args locals @@ (match cpt with
																											| 0 -> move a0 t0 @@ move a1 t1
																											| 1 -> move a2 t0 @@ move a3 t1
																											| _ -> sw t0 0 sp @@ sw t1 4 sp @@ addi sp sp 8)
																							in (code @@ next_code,(cpt+1))) (nop,0) vl
									in (let decalage = (max 0 (8*((List.length locals)-4))) in if decalage > 0 then subi sp sp decalage else nop) @@ (if recs then subi sp sp 8 @@ lw ra 0 sp @@ lw fp 4 sp else nop) @@ (let decalage = (max 0 (8*((List.length args)-2))) in if decalage > 0 then subi sp sp decalage else nop) @@ Pervasives.fst vars_decl @@ b i
  | Block(i,vl) ->					let n = (List.length locals) in
									let locals2 = vl@locals in
									let add = (let decalage = (max 0 (8*((List.length vl)-(max 0 (4-n))))) in if decalage > 0 then addi sp sp decalage else nop) in
									let i = translate_instruction i recs args locals2 in
									let n = (List.length locals2) in
									let sub = (let decalage = (max 0 (8*(min (List.length vl) (4-n)))) in if decalage > 0 then subi sp sp decalage else nop) in
									add @@ i @@ sub

let translate_program program =

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
	@@ move fp sp
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
    @@ move s1 a0
    @@ move s0 a2
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
	@@ li v0 11 
	@@ syscall
	@@ move v0 a0
	@@ li v1 0
	@@ jr ra
	
	in
	(* edit pour stocker dans t2-t9 avec un compteur *)
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
	
	let text = init @@ predefined @@ fun_code @@ built_ins in
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
