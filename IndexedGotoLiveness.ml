module IGto = IndexedGotoAST
open CommonAST

type succ_table = int list array

type liveness_info = 
	{ live_in  : string list array;
	  live_out : string list array }

	  

let mk_succ_table i = 
  let find_length i = 
	match i with
	| (n,Sequence(i1,i2)) -> find_length i2	
	| (n,_) -> n
  in
  
  let find_label l i = match i with
    | (n,Sequence(i1,i2)	-> 	let a = find_label i1 in
								let b = find_label i2 in
								if a <> -1 then a else b
	| (n,Label(k))			->	match l,k with -> Lab(s),Lab(t) -> if s=t then n else -1
	| _						-> -1
  in
  
  let find_block s i =
	-1 (*todo*)
  in
  
  let tbl = Array.make (find_length i) [] in
  let mk_succ_aux j n = 
	match j with
	| (m,Sequence((k,i1),(l,i2))	->	tbl.(m) <- [k];
										mk_succ_aux (k,i1) l;
										mk_succ_aux (l,i2) -1;
	| (m,Goto(l))					->  tbl.(m) <- [find_label l i]
	| (m,ConditionalGoto(l))		-> 	tbl.(m) <- [find_label l i;n]
	| (m,Nop)						-> 	tbl.(m) <- [-1]
	| (m,Return(e))					-> 	tbl.(m) <- [-1]
	| (m,Jump(s,l))					->  tbl.(m) <- [find_block s i]
	| (m,Block((k,i),vl))			->  tbl.(m) <- [k];
										mk_succ_aux i n
	| (m,_)							-> 	tbl.(m) <- [n]
  in mk_succ_aux i -1;
  tbl


let liveness i =
	let n