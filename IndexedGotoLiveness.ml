module IGto = IndexedGotoAST
module Gto = GotoAST
open CommonAST

type succ_table = int list array

type liveness_info = 
	{ live_in  : string list array;
	  live_out : string list array }

	  

let mk_succ_table i = 
  let rec find_length i = 
	match i with
	| (n,IGto.Sequence(i1,i2)) -> find_length i2	
	| (n,_) -> n
  in
  
  let rec find_label l i = match i with
    | (n,IGto.Sequence(i1,i2))	-> 	let a = find_label l i1 in
									let b = find_label l i2 in
									if a <> -1 then a else b
	| (n,IGto.Label(k))			->	(match (l,k) with Lab(s),Lab(t) -> if s=t then n else -1)
	| _							-> 	-1
  in
  
  let find_block s i =
	-1 (*todo*)
  in
  
  let tbl = Array.make (find_length i) [] in
  let rec mk_succ_aux j n = 
	match j with
	| (m,IGto.Sequence((k,i1),(l,i2)))	->	tbl.(m) <- [k];
											mk_succ_aux (k,i1) l;
											mk_succ_aux (l,i2) (-1);
	| (m,IGto.Goto(l))					->  tbl.(m) <- [find_label l i]
	| (m,IGto.ConditionalGoto(l,e))		-> 	tbl.(m) <- [find_label l i;n]
	| (m,IGto.Nop)						-> 	tbl.(m) <- [-1]
	| (m,IGto.Return(e))				-> 	tbl.(m) <- [-1]
	| (m,IGto.Jump(s,l))				->  tbl.(m) <- [find_block s i]
	| (m,IGto.Block((k,i),vl))			->  tbl.(m) <- [k];
											mk_succ_aux (k,i) n
	| (m,_)								-> 	tbl.(m) <- [n]
    in mk_succ_aux i (-1);
	tbl


let liveness i =
	let tbl = mk_succ_table i in
	let live_in = Array.make (Array.length tbl) [] in
	let live_out = Array.make (Array.length tbl) [] in
	
	let remove_from_list s n =
		let rec remove s l =
			match l with
			| [] 	 -> ([],false)
			| hd::tl -> if hd=s then (tl,true) else let (l,b) = remove s tl in ((hd::l),b)
		in let (l,b) = remove s (live_in.(n))
		in live_in.(n) <- l; b
	
	in let add_to_list s n =
		let rec add s l =
			match l with
			| [] -> ([s],true)
			| hd::tl -> if hd=s then (l,false) else let (l,b) = add s tl in ((hd::l),b)
		in let (l,b) = add s (live_in.(n))
		in live_in.(n) <- l; b
		
	in let rec add_alive_expr n e =
		match e with
		| Gto.Location(l)			-> 	add_alive_loc n l
		| Gto.Literal(l)			-> 	false
		| Gto.UnaryOp(o,e)			-> 	add_alive_expr n e
		| Gto.BinaryOp(o,e1,e2) 	-> 	let a1 = add_alive_expr n e1 in
										let a2 = add_alive_expr n e2 in
										a1 || a2
		| Gto.NewBlock(e,n)			-> 	add_alive_expr n e
		| Gto.LabelAddr(l)			-> 	false
		| Gto.FunCall(i,el)			-> 	List.fold_left (fun b e -> add_alive_expr n e || b) false el 	
		
	and add_alive_loc n l =
		match l with
		| Gto.Identifier(Id(s))  	->	add_to_list s n
		| Gto.BlockAccess(e1,e2) 	-> 	let a1 = add_alive_expr n e1 in
										let a2 = add_alive_expr n e2 in
										a1 || a2
		
	in let kill_loc l n =
		match l with
		| Gto.Identifier(Id(s)) -> remove_from_list s n
		| _						-> false
		
	in let rec compute_liveness i =
		match i with
		| (n,IGto.Sequence(i1,i2))		->
		| (n,IGto.Set(l,e))				->
		| (n,IGto.Label(l))				->
		| (n,IGto.Goto(l))				->
		| (n,IGto.ConditionalGoto(l,e))	->
		| (n,IGto.Nop)					->
		| (n,IGto.Jump(s,l))			-> (*todo*)
		| (n,IGto.Return(e))			->
		| (n,IGto.ProcCall(i,el))		->
		| (n,IGto.Block(i,vl))			-> 
		
	in compute_liveness i;
	{live_in = live_in; live_out=live_out}
