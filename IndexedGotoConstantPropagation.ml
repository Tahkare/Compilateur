module IGtoA = IndexedGotoAccessibility
module IGto = IndexedGotoAST
open CommonAST

let propagate i =
	let defs = IGtoA.accessibility i in
	
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
	
	in let rec constant_prop n e = match e with
		| IGto.Location(IGto.Identifier(Id(s)))	-> 	let (nb,expr) = List.fold_left (fun (acc,expr) (l,assigned_expr) -> if match_loc (IGto.Identifier(Id(s))) l then (acc+1,assigned_expr) else (acc,expr)) 
																	(0,IGto.Location(IGto.Identifier(Id("")))) defs.(n) in
													if nb == 1  then (match expr with
																| IGto.Literal(l) 	-> expr
																| IGto.Location(m) 	-> expr
																| _ 				-> IGto.Location(IGto.Identifier(Id(s))))
															else IGto.Location(IGto.Identifier(Id(s)))
		| IGto.Location(IGto.BlockAccess(e1,e2)) ->	let (nb,expr) = List.fold_left (fun (acc,expr) (l,assigned_expr) -> if match_loc (IGto.BlockAccess(e1,e2)) l then (acc+1,assigned_expr) else (acc,expr))
																	(0,IGto.Location(IGto.Identifier(Id("")))) defs.(n) in
													if nb == 1	then (match expr with
																| IGto.Literal(l) 	-> expr
																| IGto.Location(m) 	-> expr
																| _ -> IGto.Location(IGto.BlockAccess(constant_prop n e1, constant_prop n e2)))
															else IGto.Location(IGto.BlockAccess(constant_prop n e1, constant_prop n e2))
		| IGto.UnaryOp(o,e1)					-> 	let e1 = constant_prop n e1 in
													(match e1 with
													| IGto.Literal(Int(i)) 	-> IGto.Literal(Int(-i))
													| IGto.Literal(Bool(b)) -> IGto.Literal(Bool(not b))
													| _						-> IGto.UnaryOp(o,e1))
		| IGto.BinaryOp(o,e1,e2)				-> 	let (e1,e2) = (constant_prop n e1, constant_prop n e2) in
													(match (e1,e2) with
													| IGto.Literal(Int(i1)),IGto.Literal(Int(i2)) -> (match o with
														| Add -> IGto.Literal(Int(i1+i2))
														| Sub -> IGto.Literal(Int(i1-i2))
														| Mult -> IGto.Literal(Int(i1*i2))
														| Div -> IGto.Literal(Int(i1/i2))
														| Mod -> IGto.Literal(Int(i1 mod i2))
														| Eq -> IGto.Literal(Bool(i1 == i2))
														| Neq -> IGto.Literal(Bool(i1 <> i2))
														| Gt -> IGto.Literal(Bool(i1>i2))
														| Ge -> IGto.Literal(Bool(i1>=i2))
														| Lt -> IGto.Literal(Bool(i1<i2))
														| Le -> IGto.Literal(Bool(i1<=i2))
														| LEq -> IGto.Literal(Bool(i1 == i2))
														| _ -> failwith "Expected an operator compatible with integers")
													| IGto.Literal(Bool(b1)), IGto.Literal(Bool(b2)) -> (match o with
														| Eq -> IGto.Literal(Bool(b1 == b2))
														| Neq -> IGto.Literal(Bool(b1 <> b2))
														| And -> IGto.Literal(Bool(b1 && b2))
														| Or -> IGto.Literal(Bool(b1 || b2))
														| LEq -> IGto.Literal(Bool(b1 == b2))
														| _ -> failwith "Expected an operator compatible with booleans")
													| _,_ -> IGto.BinaryOp(o,e1,e2))
		| IGto.NewBlock(e1,m)					-> 	IGto.NewBlock(constant_prop n e1,m)
		| IGto.LabelAddr(l)						->	IGto.LabelAddr(l)
		| IGto.FunCall(i,el)					->	IGto.FunCall(i,List.map (fun x -> constant_prop n x) el)
		| IGto.Literal(l)						-> 	IGto.Literal(l)
		
	
	in let rec replace j = match j with
		| (n,IGto.Sequence(i1,i2))		-> (n,IGto.Sequence(replace i1, replace i2))
		| (n,IGto.Set(l,e))				-> (n,IGto.Set(l, constant_prop n e))
		| (n,IGto.Label(l))				-> (n,IGto.Label(l))
		| (n,IGto.Goto(l))				-> (n,IGto.Goto(l))
		| (n,IGto.ConditionalGoto(l,e))	-> (n,IGto.ConditionalGoto(l, constant_prop n e))
		| (n,IGto.Nop)					-> (n,IGto.Nop)
		| (n,IGto.Jump(s,l))			-> (n,IGto.Jump(s,l))
		| (n,IGto.Return(e))			-> (n,IGto.Return(constant_prop n e))
		| (n,IGto.ProcCall(i,el))		-> (n,IGto.ProcCall(i,List.map (fun x -> constant_prop n x) el))
		| (n,IGto.Block(i,vl))			-> (n,IGto.Block(replace i,vl))
	in replace i