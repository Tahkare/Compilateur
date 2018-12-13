module IGto = IndexedGotoAST
module IGtoL = IndexedGotoLiveness
open CommonAST

let liveness = ref IGtoL.({live_in = Array.make 1 [];
						   live_out = Array.make 1 []})

let rec add_interferences g i =
	match i with
	| (n,IGto.Sequence(i1,i2))					-> 	let g = add_interferences g i1 in
													add_interferences g i2
	| (n,IGto.Block(i1,vl))						-> 	add_interferences (List.fold_left (fun g (s,_) -> Graph.add_node g s) g vl) i1
	| (n,IGto.Set(IGto.Identifier(Id(u)),IGto.Location(IGto.Identifier(Id(v)))))
												-> List.fold_left (fun g (s,_) -> if s <> v then Graph.add_edge g u s else g) g !liveness.live_out.(n)
	| (n,IGto.Set(IGto.Identifier(Id(u)),_))	-> List.fold_left (fun g (s,_) -> Graph.add_edge g u s) g !liveness.live_out.(n)
	| (n,_)										-> g


let interference_graph fi =
	let g = Symb_Tbl.fold (fun key value g -> Graph.add_node g key) IGto.(fi.locals) Graph.empty in
	liveness := IGtoL.liveness IGto.(fi.code);
	add_interferences g IGto.(fi.code)