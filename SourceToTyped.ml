module Src = SourceLocalisedAST
module Typed = TypedAST
open CommonAST

exception Type_error of typ * typ * (int * int)
exception Global_var
exception Local_var

(* Contexte *)
let context = ref {identifier_types = Symb_Tbl.empty;
				   struct_types = Symb_Tbl.empty;
				   union_lists = Symb_Tbl.empty;
				   function_signatures = Symb_Tbl.empty;}

(* Variable qui stocke si une fonction en appelle d'autres ou non *)				   
let calls_fun = ref false

(* Transforme un type en une string *)
let rec tts = function
	| TypInt -> "int"
	| TypBool -> "bool"
	| TypArray t -> "array_of_"^(tts t)
	| TypStruct s -> "struct_"^s
	| TypVoid -> "void"
	| TypAny -> "any"	

(* Etend le nom d'une fonction pour gérer la surcharge *)	
let rec expand_fun_name id =
	let rec expand_aux id l = match l with
	  | [] -> id
	  | (_,t)::tl -> expand_aux (id^"_"^(tts t)) tl
	in expand_aux id (Symb_Tbl.find id (!context.function_signatures)).formals

(* Vérification d'un type par rapport à une valeur attendue *)
let rec assert_type expected tested pos =
  match (expected,tested) with
  | TypArray(t1), TypArray(t2) -> (try assert_type t1 t2 pos with (Type_error(t,e,p)) -> raise (Type_error(TypArray(t),TypArray(e),p)))
  | TypStruct(s1), TypStruct(s2) -> if s1=s2 then () else raise (Type_error(tested,expected,pos))
  | TypAny,_ -> ()
  | _,TypAny -> ()
  | _,_ -> if tested == expected then () else raise (Type_error(tested,expected,pos))

(* Fonction qui regarde si deux expressions sont identiques, utilisé pour le typage dans les switch *)
let rec assert_expr_equality l1 l2 =
	match (l1,l2) with
	| Src.Literal(Int(i1)),Src.Literal(Int(i2)) -> i1=i2
	| Src.Literal(Bool(b1)),Src.Literal(Bool(b2)) -> b1=b2
	| Src.Location(l1),Src.Location(l2) -> assert_loc_equality l1 l2
	| Src.UnaryOp(o1,e1),Src.UnaryOp(o2,e2) -> assert_expr_equality Src.(e1.expr) Src.(e2.expr) && o1=o2
	| Src.BinaryOp(o1,e11,e12),Src.BinaryOp(o2,e21,e22) -> assert_expr_equality Src.(e11.expr) Src.(e21.expr) && assert_expr_equality Src.(e12.expr) Src.(e22.expr) && o1=o2
	| _,_ -> false

(* Fonction qui regarde si deux locations sont identiques, utilisé pour le typage dans les switch *)
and assert_loc_equality l1 l2 =
	match (l1,l2) with 
	| Src.Identifier(Id(s1)),Src.Identifier(Id(s2)) -> s1=s2
	| Src.ArrayAccess(e11,e12),Src.ArrayAccess(e21,e22) -> assert_expr_equality Src.(e11.expr) Src.(e21.expr) && assert_expr_equality Src.(e12.expr) Src.(e22.expr)
	| Src.FieldAccess(e1,s1),Src.FieldAccess(e2,s2) -> assert_expr_equality Src.(e1.expr) Src.(e2.expr) && s1=s2
	| _,_ -> false

(* Fonction qui sert à trouver le type d'une variable dans une liste et lève exn sinon *)
let rec find_type s var_list exn = match var_list with
	| [] -> raise exn
	| (str,t)::tl -> if s=str then t else find_type s tl exn
	
(* Typage d'une expression *)
let rec type_expression switch name locals e = 
  match Src.(e.expr) with
  | Src.Literal(l) -> 			(match l with
								| Int(i) -> Typed.({expr = Typed.Literal(Int(i)); t = TypInt})
								| Bool(b) -> Typed.({expr = Typed.Literal(Bool(b)); t = TypBool}))
  | Src.Location(l) -> 			let lt = type_location false switch name locals l in
								Typed.({expr = Typed.Location(lt); t = lt.lt})
  | Src.UnaryOp(o,f) -> 		let t = type_expression switch name locals f in
								(match o with
								| Minus -> assert_type TypInt Typed.(t.t) Src.(e.e_pos); Typed.({expr = Typed.UnaryOp(o,t); t = TypInt})
								| Not -> assert_type TypBool Typed.(t.t) Src.(e.e_pos); Typed.({expr = Typed.UnaryOp(o,t); t = TypBool}))
  | Src.BinaryOp(o,f1,f2) -> 	if o = LEq then calls_fun := true;
								let t1 = type_expression switch name locals f1 in
								let t2 = type_expression switch name locals f2 in
								(match o with
								| Add | Sub | Mult | Div | Mod -> 	assert_type TypInt Typed.(t1.t) Src.(e.e_pos);
																	assert_type TypInt Typed.(t2.t) Src.(e.e_pos);
																	Typed.({expr = Typed.BinaryOp(o,t1,t2); t = TypInt})
								| Eq | Neq -> 						assert_type Typed.(t1.t) Typed.(t2.t) Src.(e.e_pos); Typed.({expr = Typed.BinaryOp(o,t1,t2); t = TypBool})
								| Lt | Le | Gt | Ge -> 				assert_type TypInt Typed.(t1.t) Src.(e.e_pos);
																	assert_type TypInt Typed.(t2.t) Src.(e.e_pos);
																	Typed.({expr = Typed.BinaryOp(o,t1,t2); t = TypBool})
								| And | Or -> 						assert_type TypBool Typed.(t1.t) Src.(e.e_pos);
																	assert_type TypBool Typed.(t2.t) Src.(e.e_pos);
																	Typed.({expr = Typed.BinaryOp(o,t1,t2); t = TypBool})
								| LEq -> 							Typed.({expr = Typed.BinaryOp(o,t1,t2); t = TypBool}))
  | Src.NewArray(f,t) -> 		let t1 = type_expression switch name locals f in
								assert_type TypInt Typed.(t1.t) Src.(e.e_pos);
								Typed.({expr = Typed.NewArray t1; t = TypArray(t)})
  | Src.NewRecord(s) -> 		let (i,_) = Symb_Tbl.find s !context.struct_types in 
								Typed.({expr = Typed.NewRecord(s); t = TypStruct(i)})
  | Src.FunCall(Id(i),el) -> 	calls_fun := true;
								let funtype = (Symb_Tbl.find i (!context.function_signatures)).return in
								Typed.({expr = Typed.FunCall(Id(expand_fun_name i),List.map (fun x -> type_expression switch name locals x) el); t = funtype })
  
(* Typage d'une location *) 
and type_location immutable switch name locals l = match l with
  | Src.Identifier(Id(s)) -> 	let u = Symb_Tbl.find name !context.function_signatures in
								let t = (try find_type s locals Local_var
										 with Local_var -> (try find_type s u.formals Global_var
															with Global_var -> (try Symb_Tbl.find s !context.identifier_types
																				with Not_found -> failwith s)
														   )
										) in Typed.({loc = Typed.Identifier(Id(s)); lt = t})
  | Src.ArrayAccess(f1,f2) -> 	let t1 = type_expression switch name locals f1 in
								let t2 = type_expression switch name locals f2 in
								assert_type TypInt Typed.(t2.t) Src.(f2.e_pos);
								let t3 = (match Typed.(t1.t) with 
										| TypArray(v) -> v 
										| _ -> failwith (tts (Typed.(t1.t))) )in
								Typed.({loc = Typed.ArrayAccess(t1,t2); lt = t3})
  | Src.FieldAccess(f,s) -> 	let (check,loc,tag) = switch in
								let t = type_expression switch name locals f in
								match Typed.(t.t) with
								| TypStruct(str) -> let rec find_type field_list field = 
													(match field_list with
													| [] -> failwith "Field not found"
													| (n,t,b)::tl -> if n=s then t else find_type tl field)
													(* Si on est dans un switch et que la struct à laquelle on accède est celle du switch, on va regarder les champs du tag à la place pour le typage *)
													in let u = if check && assert_expr_equality (Src.Location(loc)) Src.(f.expr) then tag else str
													in let (_,v) = Symb_Tbl.find u !context.struct_types
													in let w = find_type v.fields s
													in Typed.({loc = Typed.FieldAccess(Typed.({expr = t.expr; t = TypStruct(u)}),s); lt = w}) 
								| _ -> failwith "Expected a struct type"

(* Typage d'un Set ou d'un InitSet *)
let type_set switch b l name locals e = 
  match Src.(e.expr) with
  | _ ->   let et = type_expression switch name locals e in
		   let lt = type_location b switch name locals l in
		   assert_type Typed.(et.t) Typed.(lt.lt) Src.(e.e_pos);
		   Typed.Set(lt,et)

(* Typage d'une instruction *)		   
let rec type_instruction switch name locals (i : Src.localised_instruction) = 
  let locals = Symb_Tbl.fold (fun var typ locals_list -> (var,typ)::locals_list ) Src.(i.locals) locals in
  let instr = (match Src.(i.instr) with
  | Src.Nop -> 					Typed.Nop
  | Src.Break ->			 	Typed.Break
  | Src.Continue -> 			Typed.Continue
  | Src.Set(l,e) -> 			type_set switch true l name locals e
  | Src.InitSet(l,e) -> 		type_set switch false l name locals e
  | Src.Conditional(e,i1,i2) -> let t = type_expression switch name locals e in
								assert_type TypBool Typed.(t.t) Src.(i.i_pos);
								let j1 = type_instruction switch name locals i1 in
								let j2 = type_instruction switch name locals i2 in
								Typed.Conditional(t,j1,j2)
  | Src.Loop(e,i) -> 			let t = type_expression switch name locals e in
								assert_type TypBool Typed.(t.t) Src.(i.i_pos);
								let j = type_instruction switch name locals i in
								Typed.Loop(t,j)
  | Src.Sequence(i1,i2) -> 		let j1 = type_instruction switch name locals i1 in
								let j2 = type_instruction switch name locals i2 in
								Typed.Sequence(j1,j2)
  | Src.For(ini,e,inc,ins) -> 	let ini_ = type_instruction switch name locals ini in 
								let inc_ = type_instruction switch name locals inc in
								let ins_ = type_instruction switch name locals ins in
								let t = type_expression switch name locals e in
								assert_type TypBool Typed.(t.t) Src.(i.i_pos);
								Typed.For(ini_,t,inc_,ins_)
  | Src.Switch(v,l,ilist) -> 	let lt = type_location false switch name locals l in
								(match Typed.(lt.lt) with
								| TypStruct(s) -> 	let rec check_unique l = match l with
													| [] -> true
													| hd::[] -> true
													| hd::h2::tl -> if hd=h2 then false else check_unique (h2::tl)
													in let (tag_list,itlist) = List.fold_left (fun (t,i) x -> match x with u,j -> (u::t,(u,type_instruction (true,l,u) name locals j)::i)) ([],[]) ilist
													in let exp_tag_list = Symb_Tbl.find s !context.union_lists
													in let exhaustive = ((List.for_all (fun x -> List.mem x exp_tag_list) tag_list) && (List.for_all (fun x -> List.mem x tag_list) exp_tag_list)) || (List.exists (fun x -> x="default") tag_list)
													in let unique = check_unique (List.sort compare tag_list)
													in if unique && exhaustive then Typed.Switch(v,lt,itlist) else failwith "Switch not exhaustive or not unique"
								| _ -> failwith "Expected a struct type")
  | Src.Return(e) -> 			Typed.Return(type_expression switch name locals e)
  | Src.ProcCall(Id(i),el) -> 	calls_fun := true;
								Typed.ProcCall(Id(expand_fun_name i),List.map (fun x -> type_expression switch name locals x) el)
  | Src.TypeCheck(e1,e2) -> 	let t1 = type_expression switch name locals e1 in
								let t2 = type_expression switch name locals e2 in
								assert_type Typed.(t1.t) Typed.(t2.t) Src.(i.i_pos);
								Typed.Nop)
  in Typed.({ instr = instr; locals = Src.(i.locals); })							  

(* Initialise le contexte puis appelle la traduction pour générer le programme en Typed *)  
let type_program p =
  context := {identifier_types = Src.(p.globals);
			  struct_types = Src.(p.structs);
			  union_lists = Src.(p.union);
			  function_signatures = (let f = Symb_Tbl.add "print_int" {return=TypInt; formals=["x", TypInt]} Symb_Tbl.empty in
									 let f = Symb_Tbl.add "power" {return=TypInt; formals=["x",TypInt; "n",TypInt]} f in
									 let f = Symb_Tbl.add "print" {return=TypVoid; formals=["x", TypInt]} f in
									 let f = Symb_Tbl.add "free" {return=TypVoid; formals=["x", TypArray(TypAny)]} f in
									 let f = Symb_Tbl.add "malloc" {return=TypArray(TypAny); formals=["x", TypInt]} f in
									 let f = Symb_Tbl.add "scan_int" {return=TypInt; formals=[]} f in
									 (Symb_Tbl.fold (fun id f tbl -> Symb_Tbl.add id Src.(f.signature) tbl) Src.(p.functions) f))
			 };
  let globals = Src.(p.globals) in
  let structs = Src.(p.structs) in
  let union = Src.(p.union) in
  let functions = Symb_Tbl.fold (fun id f tbl -> calls_fun := false; 
												 let locals = Symb_Tbl.fold (fun var typ locals_list -> (var,typ)::locals_list ) Src.(f.locals) [] in
												 let code = (try type_instruction (false,Src.Identifier(Id("")),"") id locals Src.(f.code) with (Type_error(t,e,p)) -> failwith ("Expected type "^(tts e)^" but got type "^(tts t)^" at pos "^(string_of_int (Pervasives.fst p))^","^(string_of_int (Pervasives.snd p)))) in
												 Symb_Tbl.add id Typed.({signature = Src.(f.signature); code = code; locals = Src.(f.locals); recursive = !calls_fun; }) tbl) Src.(p.functions) (Symb_Tbl.empty) in
  Typed.({ globals; structs; union; functions; })
