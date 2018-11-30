module IGto = IndexedGotoAST
module Gto = GotoAST
module IGtoL = IndexedGotoLiveness
open CommonAST

let step i =
	let liveness = IGtoL.liveness i in
	
	let rec has_fun_call e =
		match e with
		| Gto.Literal(l)						-> false
		| Gto.Location(Gto.Identifier(Id(s))) 	-> false
		| Gto.Location(Gto.BlockAccess(e1,e2))	-> has_fun_call e1 || has_fun_call e2
		| Gto.UnaryOp(o,e)						-> has_fun_call e
		| Gto.BinaryOp(o,e1,e2)					-> has_fun_call e1 || has_fun_call e2
		| Gto.NewBlock(e,n)						-> has_fun_call e
		| Gto.LabelAddr(l)						-> false
		| Gto.FunCall(i,el)						-> true
		
	in let is_alive n l =
		 match l with
		 | Gto.Identifier(Id(s))  -> List.exists (fun x -> x=s) (liveness.live_out.(n)) 
		 | _ -> true
	
	in let rec elim i =
		 match i with
		 | (n,IGto.Sequence(i1,i2))	-> 	let (i1,b1) = elim i1 in
										let (i2,b2) = elim i2 in
										((n,IGto.Sequence(i1, i2)),(b1 || b2))
		 | (n,IGto.Set(l,e))		-> if is_alive n l || has_fun_call e then (i,false) else ((n,IGto.Nop),true) 
		 | _						-> (i,false)
	in elim i

let rec dead_code_elim i =
  let (i1,b) = step i in
  if b then dead_code_elim i1 else i1
