module IGto = IndexedGotoAST
open CommonAST

type succ_table = int list array

type liveness_info = 
	{ live_in  : (string * int) list array;
	  live_out : (string * int) list array }

let unique = List.sort_uniq compare 

let mk_succ_table i =
  let rec find_length i = 
	match i with
	| (n,IGto.Sequence(i1,i2)) -> let a = find_length i1 in
								  let b = find_length i2 in
								  max a b
	| (n,IGto.Block(j,_))		-> find_length j
	| (n,_) -> n
  
  in let rec find_label l i = match i with
    | (n,IGto.Sequence(i1,i2))	-> 	let a = find_label l i1 in
									let b = find_label l i2 in
									if a <> -1 then a else b
	| (n,IGto.Block(j,vl))		->  find_label l j
	| (n,IGto.Label(k))			->	(match (l,k) with Lab(s),Lab(t) -> if s=t then n else -1)
	| _							-> 	-1
  
  in let find_block s i =
	let cpt = ref 0
	
	in let rec explore j acc =
		match j with
		| (n,IGto.Sequence(i1,i2))	-> 	let a1 = explore i1 acc in
										explore i2 (a1@acc)
		| (n,IGto.Label(l))			->	cpt := !cpt+1;
										if (!cpt mod 2) = 0 then n::acc else acc
		| (n,_)						->  acc
	
	in let rec find s j =
		match j with
		| (n,IGto.Sequence(i1,i2)) 	-> 	let a = find s i1 in
										let b = find s i2 in
										if a = [] then b else a
		| (n,IGto.Block(i,vl))		->	if (List.length vl = 1) && (List.hd vl = (s,TypArray(TypAny)))
										then explore j [] else find s i
		| (n,_)						-> 	[]
	in match find s i with
		| hd::tl -> tl
		| [] -> []
  
  in let tbl = Array.make ((find_length i)+1) []
  
  in let rec mk_succ_aux j n = 
	match j with
	| (m,IGto.Sequence((k,i1),(l,i2)))	->  tbl.(m) <- [k];
											mk_succ_aux (k,i1) l;
											mk_succ_aux (l,i2) n;
	| (m,IGto.Goto(l))					->  tbl.(m) <- [find_label l i]
	| (m,IGto.ConditionalGoto(l,e))		-> 	tbl.(m) <- [find_label l i;n]
	| (m,IGto.Return(e))				-> 	tbl.(m) <- [-1]
	| (m,IGto.Jump(s,l))				->  tbl.(m) <- find_block s i
	| (m,IGto.Block((k,i),vl))			->  tbl.(m) <- [k];
											mk_succ_aux (k,i) n
	| (m,_)								-> 	tbl.(m) <- [n]
    in mk_succ_aux i (-1);
	tbl


	
let mk_pred_table tbl =
	let pred_tbl = Array.make (Array.length tbl) [] in
	for i=0 to ((Array.length tbl)-1) do
		List.iter (fun x -> if x <> -1 then pred_tbl.(x) <- i::pred_tbl.(x)) tbl.(i)
	done;
	pred_tbl

let mk_instr_tbl i tbl =
	let instr_tbl = Array.make (Array.length tbl) (-1,IGto.Nop) in
	let rec mk_instr_aux i = match i with
		| (n,IGto.Sequence(i1,i2)) 	-> 	instr_tbl.(n) <- i;
										mk_instr_aux i1;
										mk_instr_aux i2;
		| (n,IGto.Block(i1,vl))		->	instr_tbl.(n) <- i;
										mk_instr_aux i1
		| (n,_)						->  instr_tbl.(n) <- i
	in mk_instr_aux i;
	instr_tbl
	
let liveness i =
	let succ_tbl = mk_succ_table i in
	let pred_tbl = mk_pred_table succ_tbl in
	let live_in = Array.make (Array.length succ_tbl) [] in
	let live_out = Array.make (Array.length succ_tbl) [] in
	let instr_tbl = mk_instr_tbl i succ_tbl in
	let explored = Array.make (Array.length succ_tbl) false in
	
	let remove_from_list s n =
		let rec remove s l acc =
			match l with
			| [] 	 -> acc
			| (hd,m)::tl -> if hd=s then remove s tl acc else remove s tl ((hd,m)::acc)
		in let l = remove s (live_in.(n)) []
		in live_in.(n) <- l
	
	in let add_to_list s n =
		let rec add s l acc =
			match l with
			| [] -> (s,n)::acc
			| (hd,m)::tl -> if hd=s && m=n then acc@tl else add s tl ((hd,m)::acc)
		in let l = add s (live_in.(n)) []
		in live_in.(n) <- l
		
	in let rec add_alive_expr n e =
		match e with
		| IGto.Location(l)			-> 	add_alive_loc n l
		| IGto.Literal(l)			-> 	()
		| IGto.UnaryOp(o,e)			-> 	add_alive_expr n e
		| IGto.BinaryOp(o,e1,e2) 	-> 	add_alive_expr n e1;
										add_alive_expr n e2
		| IGto.NewBlock(e,n)			-> 	add_alive_expr n e
		| IGto.LabelAddr(l)			-> 	()
		| IGto.FunCall(i,el)		-> 	List.iter (fun e -> add_alive_expr n e) el 	
		
	and add_alive_loc n l =
		match l with
		| IGto.Identifier(Id(s))  	->	add_to_list s n
		| IGto.BlockAccess(e1,e2) 	-> 	add_alive_expr n e1;
										add_alive_expr n e2
		
	in let kill_loc n l =
		match l with
		| IGto.Identifier(Id(s)) -> remove_from_list s n
		| _						-> ()
	
	in let queue = Queue.create () in
	for i=0 to ((Array.length succ_tbl)-1) do
		(try (if List.hd succ_tbl.(i) == -1 then Queue.push i queue) with Failure _ -> ())
	done;
	
	let rec compute_liveness () =
		if Queue.is_empty queue
		then ()
		else begin
				let n = Queue.pop queue in
				let l = List.length live_in.(n) in
				let i = instr_tbl.(n) in
				(match i with
				| (n,IGto.Sequence((k,i1),_))	->	live_out.(n) <- live_in.(k);
													live_in.(n) <- live_out.(n)
				| (n,IGto.Block((k,i1),_))		->	live_out.(n) <- live_in.(k);
													live_in.(n) <- live_out.(n)
				| (n,IGto.Set(l,e))				->	let o = List.hd succ_tbl.(n) in
													if o <> -1 then live_out.(n) <- live_in.(o);
													live_in.(n) <- live_out.(n);
													kill_loc n l;
													add_alive_expr n e
				| (n,IGto.Label(l))				->  let o = List.hd succ_tbl.(n) in
													if o <> -1 then live_out.(n) <- live_in.(o);
													live_in.(n) <- live_out.(n)
				| (n,IGto.Goto(l))				->	let o = List.hd succ_tbl.(n) in
													if o <> -1 then live_out.(n) <- live_in.(o);
													live_in.(n) <- live_out.(n)
				| (n,IGto.Nop)					-> 	let o = List.hd succ_tbl.(n) in
													if o <> -1 then live_out.(n) <- live_in.(o);
													live_in.(n) <- live_out.(n)
				| (n,IGto.Return(e))			->  add_alive_expr n e
				| (n,IGto.ConditionalGoto(l,e))	->	live_out.(n) <- [];
													List.iter (fun k -> if k <> -1 then live_out.(n) <- (live_out.(n))@(live_in.(k))) succ_tbl.(n);
													live_out.(n) <- unique live_out.(n);
													live_in.(n) <- live_out.(n);
													add_alive_expr n e
				| (n,IGto.Jump(s,l))			->	live_out.(n) <- [];
													List.iter (fun k -> if k <> -1 then live_out.(n) <- (live_out.(n))@(live_in.(k))) succ_tbl.(n);
													live_out.(n) <- unique live_out.(n);
													live_in.(n) <- live_out.(n)
				| (n,IGto.ProcCall(i,el))		->	let o = List.hd succ_tbl.(n) in
													if o <> -1 then live_out.(n) <- live_in.(o);
													live_in.(n) <- live_out.(n);
													List.iter (fun e -> add_alive_expr n e) el);
				if List.length live_in.(n) > l || not explored.(n) then List.iter (fun x -> Queue.push x queue) pred_tbl.(n); explored.(n) <- true;
				compute_liveness ()
			 end
	in compute_liveness();
	   {live_in = live_in; live_out=live_out}
