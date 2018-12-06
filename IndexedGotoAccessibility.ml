module IGto = IndexedGotoAST
open CommonAST

let accessibility i = 
	let tbl = IndexedGotoLiveness.mk_succ_table i in
	let definitions = Array.make (Array.length tbl) [] in
	
	let rec match_expr e1 e2 = match (e1,e2) with
		| IGto.Literal(Int(i1)),IGto.Literal(Int(i2))			-> i1 = i2
		| IGto.Literal(Bool(b1)),IGto.Literal(Bool(b2))			-> b1 = b2
		| IGto.Location(l1),IGto.Location(l2)					-> match_loc l1 l2
		| IGto.UnaryOp(o1,e1),IGto.UnaryOp(o2,e2)				-> o1 = o2 && match_expr e1 e2
		| IGto.BinaryOp(o1,e11,e12),IGto.BinaryOp(o2,e21,e22)	-> o1 = o2 && match_expr e11 e21 && match_expr e12 e22
		| IGto.NewBlock(e1,n1),IGto.NewBlock(e2,n2)				-> n1 = n2 && match_expr e1 e2
		| IGto.LabelAddr(Lab(s1)),IGto.LabelAddr(Lab(s2))		-> s1 = s2
		| IGto.FunCall(i1,el1),IGto.FunCall(i2,el2)				-> i1 = i2 && List.for_all2 (fun x y -> match_expr x y) el1 el2
		| _,_													-> false
	
	and match_loc l1 l2 = match (l1,l2) with
		| IGto.Identifier(Id(s1)),IGto.Identifier(Id(s2)) 		-> s1 = s2
		| IGto.BlockAccess(e11,e12),IGto.BlockAccess(e21,e22) 	-> match_expr e11 e21 && match_expr e12 e22
		| _,_													-> false
	
	in let rec kill_def l defs =
		match defs with
		| [] -> []
		| (k,e)::tl -> if match_loc l k then kill_def l tl else (k,e)::(kill_def l tl)
	
	
	in let rec build_definitions j = match j with
		| (n,IGto.Sequence(i1,i2)) 		-> 	let o = List.hd tbl.(n) in
											if o <> -1 then definitions.(o) <- definitions.(n)@definitions.(o);
											build_definitions i1; 
											build_definitions i2
		| (n,IGto.Block(i,vl))			-> 	let o = List.hd tbl.(n) in
											if o <> -1 then definitions.(o) <- definitions.(n)@definitions.(o);
											build_definitions i
		| (n,IGto.Set(l,e))				-> 	definitions.(n) <- kill_def l definitions.(n);
											definitions.(n) <- (l,e)::definitions.(n);
											let o = List.hd tbl.(n) in
											if o <> -1 then definitions.(o) <- definitions.(n)@definitions.(o)
		| (n,IGto.ConditionalGoto(l,e)) ->	List.iter (fun o -> if o <> -1 then definitions.(o) <- definitions.(n)@definitions.(o)) tbl.(n);
		| (n,IGto.Jump(s,l))			->  (*todo*) ()
		| (n,_)							-> 	let o = List.hd tbl.(n) in
											if o <> -1 then definitions.(o) <- definitions.(n)@definitions.(o)
	in build_definitions i;
	definitions