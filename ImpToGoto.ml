module Imp = ImpAST
module Gto = GotoAST
open CommonAST

let (++) = Gto.(++)
  
let new_label =
  let cpt = ref 0 in
  fun () -> incr cpt; CommonAST.Lab (Printf.sprintf "_label_%i" !cpt)

(* Traduction d'une expression *)
let rec translate_expression = function
  | Imp.Literal(l) -> 			Gto.Literal(l)
  | Imp.Location(l) -> 			Gto.Location(translate_location l)
  (* Dans le cas où on a des valeurs fixes, on précalcule les résultats pour optimiser la traduction vers MIPS *)
  | Imp.UnaryOp(o,e) -> 		let e = translate_expression e in (match e with
								| Gto.Literal(Int(i)) -> Gto.Literal(Int(-i))
								| Gto.Literal(Bool(b)) -> Gto.Literal(Bool(not b))
								| _ -> Gto.UnaryOp(o,e))
  (* Idem pour les opérateurs binaires *)
  | Imp.BinaryOp(o,e1,e2) -> 	let (e1,e2) = (translate_expression e1, translate_expression e2) in (match(e1,e2) with
								| Gto.Literal(Int(i1)),Gto.Literal(Int(i2)) -> (match o with
									| Add -> Gto.Literal(Int(i1+i2))
									| Sub -> Gto.Literal(Int(i1-i2))
									| Mult -> Gto.Literal(Int(i1*i2))
									| Div -> Gto.Literal(Int(i1/i2))
									| Mod -> Gto.Literal(Int(i1 mod i2))
									| Eq -> Gto.Literal(Bool(i1 == i2))
									| Neq -> Gto.Literal(Bool(i1 <> i2))
									| Gt -> Gto.Literal(Bool(i1>i2))
									| Ge -> Gto.Literal(Bool(i1>=i2))
									| Lt -> Gto.Literal(Bool(i1<i2))
									| Le -> Gto.Literal(Bool(i1<=i2))
									| _ -> failwith "Expected an operator compatible with integers")
								| Gto.Literal(Bool(b1)),Gto.Literal(Bool(b2)) -> (match o with
									| Eq -> Gto.Literal(Bool(b1 == b2))
									| Neq -> Gto.Literal(Bool(b1 <> b2))
									| And -> Gto.Literal(Bool(b1 && b2))
									| Or -> Gto.Literal(Bool(b1 || b2))
									| _ -> failwith "Expected an operator compatible with booleans")
								| _,_ -> Gto.BinaryOp(o,e1,e2))
  | Imp.NewBlock(e,n) -> 		Gto.NewBlock(translate_expression e,n)
  | Imp.FunCall(i,el) -> 		Gto.FunCall(i,List.map (fun x -> translate_expression x) el)

(* Traduction d'une location *)
and translate_location = function
  | Imp.Identifier(i) -> 		Gto.Identifier(i)
  | Imp.BlockAccess(e1,e2) -> 	Gto.BlockAccess(translate_expression e1, translate_expression e2)


(* Traduction d'une instruction avec les labels break et continue en argument *)
let rec translate_loop (i : ImpAST.typed_instruction) c_label b_label = 
  let locals = Symb_Tbl.fold (fun var typ locals_list -> (var,typ)::locals_list) Imp.(i.locals) [] in
  let instr = (match Imp.(i.instr) with
  | Imp.Nop -> 					Gto.Nop
  | Imp.Set(l,e) -> 			Gto.Set(translate_location l, translate_expression e)
  | Imp.Break -> 				Gto.Goto(b_label)
  | Imp.Continue -> 			Gto.Goto(c_label)
  | Imp.Sequence(i1,i2) -> 		Gto.Sequence(translate_loop i1 c_label b_label, translate_loop i2 c_label b_label)
  | Imp.Loop(e,i) -> 			let begin_label = new_label () in 
								let cond_label = new_label () in 
								let end_label = new_label () in
								Gto.Goto(cond_label) ++ 
								Gto.Label(begin_label) ++ 
								(translate_loop i cond_label end_label) ++ 
								Gto.Label(cond_label) ++ 
								Gto.ConditionalGoto(begin_label, translate_expression e) ++ 
								Gto.Label(end_label)
  | Imp.For(ini,c,inc,ins) -> 	let begin_label = new_label () in 
								let cond_label = new_label () in 
								let end_label = new_label () in
								let continue_label = new_label () in
								(translate_loop ini c_label b_label) ++ 
								Gto.Goto(cond_label) ++ 
								Gto.Label(begin_label) ++ 
								(translate_loop ins continue_label end_label) ++
								Gto.Label(continue_label) ++ 
								(translate_loop inc c_label b_label) ++ 
								Gto.Label(cond_label) ++ 
								Gto.ConditionalGoto(begin_label, translate_expression c) ++ 
								Gto.Label(end_label)
  | Imp.Conditional(e,i1,i2) -> let then_label = new_label () in 
								let else_label = new_label () in 
								let end_label = new_label () in
								Gto.ConditionalGoto(then_label,translate_expression e) ++ 
								Gto.Goto(else_label) ++ 
								Gto.Label(then_label) ++ 
								(translate_loop i1 c_label b_label) ++ 
								Gto.Goto(end_label) ++ 
								Gto.Label(else_label) ++ 
								(translate_loop i2 c_label b_label) ++ 
								Gto.Label(end_label)
  | Imp.Switch(s,l,ilist) -> 	(let rec translate_list n s curr_label end_label after_branch_label = function
								| (t,i)::[] -> 	let instr_label = new_label () in
												Gto.Label(curr_label) ++
												Gto.Set(Gto.BlockAccess(s,Gto.Literal(Int(n))),Gto.LabelAddr(instr_label)) ++
												Gto.Goto(end_label) ++
												Gto.Label(instr_label) ++
												translate_loop i c_label b_label ++
												Gto.Goto(after_branch_label)
								| (t,i)::tl -> 	let instr_label = new_label () in
												let next_label = new_label () in
												Gto.Label(curr_label) ++
												Gto.Set(Gto.BlockAccess(s,Gto.Literal(Int(n))),Gto.LabelAddr(instr_label)) ++
												Gto.Goto(next_label) ++
												Gto.Label(instr_label) ++
												translate_loop i c_label b_label ++
												Gto.Goto(after_branch_label) ++
												translate_list (n+1) s next_label end_label after_branch_label tl
								| _ -> failwith "Expected a non-empty list"
								in let t = Gto.Location(Gto.Identifier(Id(s)))
								in let next_label = new_label ()
								in let end_label = new_label ()
								in let after_branch_label = new_label ()
								in
								Gto.Set(Gto.Identifier(Id(s)),Gto.NewBlock(Gto.Literal(Int(List.length ilist+2)),0)) ++
								translate_list 0 t next_label end_label after_branch_label ilist ++
								Gto.Label(end_label) ++
								Gto.Block(Gto.Jump(s,translate_location l),[(s,TypArray(TypAny))]) ++
								Gto.Label(after_branch_label))		
  | Imp.Return(e) -> 			Gto.Return(translate_expression e)
  | Imp.ProcCall(i,el) -> 		Gto.ProcCall(i,List.map (fun x -> translate_expression x) el)
  ) in Gto.Block(instr,locals)
  

(* Les labels break et continue sont par défaut initialisés à atoi_error. Ainsi, si on les appelle sans être entré dans une boucle, le programme plantera *)
let translate_instruction (i : ImpAST.typed_instruction) = translate_loop i (Lab("atoi_error")) (Lab("atoi_error"))

(* On traduit le programme en Goto *)
let translate_program p = Gto.({
  globals = Imp.(p.globals);
  functions = Symb_Tbl.fold (fun id f tbl -> Symb_Tbl.add id Gto.({signature= Imp.(f.signature); code=translate_instruction Imp.(f.code); locals = Imp.(f.locals); recursive = Imp.(f.recursive)}) tbl) Imp.(p.functions) (Symb_Tbl.empty);
})
