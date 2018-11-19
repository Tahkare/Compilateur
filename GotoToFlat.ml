module Flat = FlatAST
module Gto = GotoAST
open CommonAST

let (++) = Flat.(++)

let rec make_list n = match n with
  | 0 -> [("tmp"^(string_of_int n),TypInt)]
  | _ -> ("tmp"^(string_of_int n),TypInt)::(make_list (n-1))

let max_depth = ref 0
let jumps = ref []

let tmp depth = Flat.Identifier(Id("tmp"^(string_of_int depth)))	(* Var tmp de valeur depth sous forme de location *)
let tmpl depth = Flat.Location(tmp depth)							(* Var tmp de valeur depth sous forme de value *)
let set depth l = Flat.FlatSet(tmp depth,l)							(* Assignation d'une expression à une location *)
let setl depth l = Flat.Set(tmp depth,l)							(* Assignation d'une value à une location *)

(* On traduit l'expression récursivement *)
let rec translate_expression terminal depth e =
  max_depth := max !max_depth depth;
  match e with
  | Gto.Literal(l) -> 			set depth (Flat.Literal(l))
  | Gto.Location(l) -> 			(match (translate_location depth l) with code,l -> 
														code ++ 
														setl depth (Flat.Location(l)))
  | Gto.UnaryOp(o,e) -> 		translate_expression false depth e ++
								set depth (Flat.UnaryOp(o,tmpl depth))
  | Gto.BinaryOp(o,e1,e2) ->	translate_expression false depth e1 ++
								translate_expression false (depth+1) e2 ++
								set depth (Flat.BinaryOp(o,(tmpl depth),(tmpl (depth+1))))
  | Gto.NewBlock(e,n) ->		translate_expression false depth e ++
								set depth (Flat.NewBlock((tmpl depth),n))
  | Gto.LabelAddr(l) ->    		set depth (Flat.LabelAddr(l))
  | Gto.FunCall(i,el) ->    	let (vars,code) = List.fold_left (fun (vars,code) x -> vars@[Flat.Location(Flat.Identifier(Id("tmp"^(string_of_int(depth+(List.length vars))))))], (translate_expression false (depth+(List.length vars)) x)++code) ([],Flat.Nop) el in
								code ++
								set depth (if terminal then Flat.TermFunCall(i,vars) else Flat.FunCall(i,vars))
								
and translate_location depth l = 
  max_depth := max !max_depth depth;
  match l with
  | Gto.Identifier(Id(s)) ->	Flat.Nop,Flat.Identifier(Id(s))
  | Gto.BlockAccess(e1,e2) ->	((translate_expression false depth e1 ++ translate_expression false (depth+1) e2),
								(Flat.BlockAccess(tmpl depth,tmpl (depth+1))))

(* On traduit l'instruction en prenant en compte la déclaration de variables temporaires à chaque instruction *)
let rec translate_instruction terminal = function
  | Gto.Sequence(i1,i2) ->			translate_instruction false i1 ++
									translate_instruction terminal i2
  | Gto.Set(l,e) ->					(match (translate_location 1 l) with code,l ->
														let e = translate_expression false 0 e in
														e ++ code ++ Flat.Set(l,tmpl 0))												
  | Gto.Label(l) ->					Flat.Label(l)
  | Gto.Goto(l) ->					Flat.Goto(l)
  | Gto.ConditionalGoto(l,e) ->     let e = translate_expression false 0 e in
									e ++ Flat.ConditionalGoto(l, tmpl 0)								
  | Gto.Nop ->						Flat.Nop
  | Gto.Jump(s,l) ->				jumps := (s,TypArray(TypAny))::(!jumps);
									(match (translate_location 0 l) with code,l ->
														code ++ Flat.Jump(s,l))
  | Gto.Return(e) ->				let e = translate_expression true 0 e in
									e ++ Flat.Return(tmpl 0)
  | Gto.ProcCall(i,el) ->			let (vars,code) = List.fold_left (fun (vars,code) x -> vars@[Flat.Location(Flat.Identifier(Id("tmp"^(string_of_int (List.length vars)))))], (translate_expression false (List.length vars) x)++code) ([],Flat.Nop) el in
									code ++ (if terminal then Flat.TermProcCall(i,vars) else Flat.ProcCall(i,vars))
  | Gto.Block(i,vl) ->				Flat.Block(translate_instruction terminal i,vl)	
		  
(* On traduit le programme en Flat *)
let translate_program p = Flat.({
  globals = Gto.(p.globals);
  functions = Symb_Tbl.fold (fun id f tbl -> max_depth := 0; jumps := [];
							let code = translate_instruction true Gto.(f.code) in
							let code = Flat.Block(code, (make_list !max_depth)@(!jumps)) in
							Symb_Tbl.add id Flat.({signature= Gto.(f.signature); code=code; locals = Gto.(f.locals); recursive = Gto.(f.recursive)}) tbl) Gto.(p.functions) (Symb_Tbl.empty);
})
