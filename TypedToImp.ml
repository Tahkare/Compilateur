module Typed = TypedAST
module Imp = ImpAST
open CommonAST


let struct_tbl = ref Symb_Tbl.empty
let ident_tbl = ref Symb_Tbl.empty
let union_tbl = ref Symb_Tbl.empty

(* Renvoie la position d'un champ dans une structure *)
let find_pos f s =
	(let rec aux f s n = match f with
		[] -> failwith "Field not found"
		| (s2,_,_)::tl -> if s = s2 then n else aux tl s (n+1)
	in aux f s 0)

(* Renvoie le numéro associé à une étiquette dans une structure union *)
let find_pos_union f s =
	let rec aux f s n = match f with
		[] -> failwith "Tag not found"
		| hd::tl -> if hd=s then n else aux tl s (n+1)
	in aux f s 1

(* Renvoie si deux types sont égaux ou non *)
let rec assert_type t1 t2 = 
  match (t1,t2) with
  | TypArray(t1),TypArray(t2) -> assert_type t1 t2
  | TypStruct(s1),TypStruct(s2) -> s1=s2
  | TypInt,TypInt -> true
  | TypBool,TypBool -> true
  | _,_ -> false
 
(* Traduction d'une expression *) 
let rec translate_expression e = match Typed.(e.expr) with
  | Typed.Literal(l) -> 		Imp.Literal(l)
  | Typed.Location(l) -> 		Imp.Location(translate_location l)
  | Typed.UnaryOp(o,e) -> 		Imp.UnaryOp(o,translate_expression e)
  | Typed.BinaryOp(o,e1,e2) -> 	(match o with
								| LEq -> 	if assert_type Typed.(e1.t) Typed.(e2.t) then Imp.BinaryOp(o,translate_expression e1,translate_expression e2)
																					 else Imp.Literal(Bool(false))
								| _ -> 		Imp.BinaryOp(o,translate_expression e1, translate_expression e2))
  | Typed.NewArray(e) -> 		Imp.NewBlock(translate_expression e,0)
  | Typed.NewRecord(s) -> 		let (t,f) = Symb_Tbl.find s !struct_tbl in
								let n = (if t=s then 0 else find_pos_union (Symb_Tbl.find t !union_tbl) s) in
								let l = List.length (f.fields) in
								Imp.NewBlock(Imp.Literal(Int(l)),n)
  | Typed.FunCall(i,el) -> 		Imp.FunCall(i,List.map (fun x -> translate_expression x) el)

(* Traduction d'une location *)
and translate_location l = match Typed.(l.loc) with
  | Typed.Identifier(i) -> 		Imp.Identifier(i)
  | Typed.ArrayAccess(e1,e2) -> Imp.BlockAccess(translate_expression e1,translate_expression e2)
  | Typed.FieldAccess(e,s) -> 	(match Typed.(e.t) with 
								| TypStruct(u) -> let (_,v) = (Symb_Tbl.find u !struct_tbl) in let pos = find_pos v.fields s in Imp.BlockAccess(translate_expression e, Imp.Literal(Int(pos)))
								| _ -> failwith "Expected a struct type")
 
(* Traduction d'une expression *)
let rec translate_instruction i = 
  let instr = (match Typed.(i.instr) with
  | Typed.Set(l,e) -> 				Imp.Set(translate_location l, translate_expression e)
  | Typed.Conditional(e,i1,i2) -> 	Imp.Conditional(translate_expression e, translate_instruction i1, translate_instruction i2)
  | Typed.Loop(e,i) -> 				Imp.Loop(translate_expression e,translate_instruction i)
  | Typed.Sequence(i1,i2) -> 		Imp.Sequence(translate_instruction i1, translate_instruction i2)
  | Typed.For(ini,c,inc,ins) -> 	Imp.For(translate_instruction ini, translate_expression c, translate_instruction inc, translate_instruction ins)
  | Typed.Break -> 					Imp.Break
  | Typed.Continue -> 				Imp.Continue
  | Typed.Nop -> 					Imp.Nop
  | Typed.Switch(s,l,ilist) -> 		(match Typed.(l.lt) with
									| TypStruct(u) -> 	let tag_list = ref (Symb_Tbl.find u !union_tbl) in
														let default_instr = ref Imp.({instr= Imp.Nop; locals = Symb_Tbl.empty }) in
														let rec add_default_fields = function
															| [] -> []
															| hd::tl -> (Imp.Literal(Int(find_pos_union (Symb_Tbl.find u !union_tbl) hd)),!default_instr)::(add_default_fields tl)
														in let rec remove_field s = function
															| [] -> []
															| hd::tl -> if hd=s then tl else (hd::(remove_field s tl))
														in let rec add_fields = function
															| [] -> []
															| (v,i)::tl -> if v="default" then begin default_instr := translate_instruction i; add_fields tl end
																						  else begin tag_list := remove_field v !tag_list; (Imp.Literal(Int(find_pos_union (Symb_Tbl.find u !union_tbl) v)),translate_instruction i)::(add_fields tl) end
														in let a = add_fields ilist
														in let b = add_default_fields !tag_list
														in Imp.Switch(s,translate_location l, a@b)
									| _ -> failwith "Expected a struct")
  | Typed.Return(e) -> 				Imp.Return(translate_expression e)
  | Typed.ProcCall(i,el) -> 		Imp.ProcCall(i,List.map (fun x -> translate_expression x) el))
  in Imp.({ instr = instr; locals = Typed.(i.locals); })
 
(* Initialise le contexte puis appelle la traduction pour générer le programme en Imp *)
let translate_program p =
  ident_tbl := Typed.(p.globals);
  struct_tbl := Typed.(p.structs);
  union_tbl := Typed.(p.union);
  let globals = Typed.(p.globals) in
  let functions = Symb_Tbl.fold (fun id f tbl -> Symb_Tbl.add id Imp.({signature = Typed.(f.signature); code = translate_instruction Typed.(f.code); locals = Typed.(f.locals); recursive = Typed.(f.recursive)}) tbl) Typed.(p.functions) (Symb_Tbl.empty) in
  Imp.({ globals; functions })
