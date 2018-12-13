module IGto = IndexedGotoAST
module IGtoL = IndexedGotoLiveness
module IGtoC = IndexedGotoConstantPropagation
open CommonAST
open GotoAST

let step i =	
	let const_propagation = IGtoC.propagate i in
	let liveness = IGtoL.liveness const_propagation in
	
	(* DEBUG -- AFFICHE LES VARS IN ET OUT DE CHAQUE INSTR *)
	let tbl = IGtoL.mk_succ_table i in
	let a = liveness.live_in in
	let b = liveness.live_out in
	for i=0 to (Array.length a)-1 do
		print_int i; print_string " : ";
		List.iter (fun s -> print_string ((string_of_int s)^" ")) tbl.(i);
		print_string "\n";
		List.iter (fun (s,n) -> print_string (s^" ");print_int n;print_string " ") a.(i);
		print_string "\n";
		List.iter (fun (s,n) -> print_string (s^" ");print_int n;print_string " ") b.(i);
		print_string "\n";
	done;
	
	let rec has_fun_call e =
		match e with
		| IGto.Literal(l)							-> false
		| IGto.Location(IGto.Identifier(Id(s))) 	-> false
		| IGto.Location(IGto.BlockAccess(e1,e2))	-> has_fun_call e1 || has_fun_call e2
		| IGto.UnaryOp(o,e)							-> has_fun_call e
		| IGto.BinaryOp(o,e1,e2)					-> has_fun_call e1 || has_fun_call e2
		| IGto.NewBlock(e,n)						-> has_fun_call e
		| IGto.LabelAddr(l)							-> false
		| IGto.FunCall(i,el)						-> true
		
	in let is_alive n l =
		 match l with
		 | IGto.Identifier(Id(s))  -> List.exists (fun (x,m) -> x=s) (liveness.live_out.(n)) 
		 | _ -> true
	
	in let has_eliminated tbl =
		let b = ref false in
		for i=0 to ((Array.length tbl)-1) do
			if tbl.(i) = true then b := true 
		done;
		!b
	
	in let rec elim i =
		let eliminated = Array.make (Array.length liveness.live_in) false in
		let rec elim_aux i =
			let (n,j) = i in
			liveness.live_out.(n) <- List.fold_left (fun acc (hd,m) -> if eliminated.(m) then acc else (hd,m)::acc) [] liveness.live_out.(n);
			liveness.live_in.(n) <- List.fold_left (fun acc (hd,m) -> if eliminated.(m) then acc else (hd,m)::acc) [] liveness.live_in.(n);
			match i with
			| (n,IGto.Sequence(i1,i2))	-> 	let (i1,b1) = elim i1 in
											let (i2,b2) = elim i2 in
											((n,IGto.Sequence(i1, i2)),(b1 || b2))
			| (n,IGto.Block(j,vl))		->  let (j,b) = elim j in
											((n,IGto.Block(j,vl)),b)
			| (n,IGto.Set(l,e))			-> if is_alive n l || has_fun_call e then (i,false) else begin eliminated.(n) <- true; ((n,IGto.Nop),true) end
			| _							-> (i,false)
		in let (i1,b) = elim_aux i
		in if b then elim_aux i1 else (i1,has_eliminated eliminated)
		
	
	in elim const_propagation

let unreachable_elim i =
	let tbl = IGtoL.mk_succ_table i in
	let reach = Array.make (Array.length tbl) false in
	reach.(0) <- true;
	let queue = Queue.create () in
	List.iter (fun x -> if x <> -1 then Queue.push x queue) tbl.(0); 
	
	let rec mark_reachable () =
		if Queue.is_empty queue 
		then ()
		else begin
				let n = Queue.pop queue in
				if reach.(n) then ()
				else begin
						reach.(n) <- true;
						List.iter (fun x -> if x <> -1 then Queue.push x queue) tbl.(n)
					 end;
			    mark_reachable ()
			 end
	in mark_reachable ();
	
	let rec elim i = match i with
		| (n,IGto.Sequence(i1,i2)) 	-> if reach.(n) then (n,IGto.Sequence(elim i1, elim i2)) else (n,IGto.Nop)
		| (n,IGto.Block(j,vl))		-> if reach.(n) then (n,IGto.Block(elim j,vl)) else (n,IGto.Nop)
		| (n,_) 					-> if reach.(n) then i else (n,IGto.Nop)
	in elim i
	
let rec dead_code_elim i =
  let (i1,b) = step i in
  if b then dead_code_elim i1 else i1


let dead_code_clear (p : GotoAST.program) =
	let prog = IndexedGotoTranslate.index_program p in
	let prog = IGto.({  globals = IGto.(prog.globals);
						functions = Symb_Tbl.map (fun fi -> IGto.({signature = fi.signature; code = dead_code_elim (unreachable_elim fi.code); locals = fi.locals; recursive = fi.recursive})) IGto.(prog.functions) })
	in IndexedGotoTranslate.strip_program prog