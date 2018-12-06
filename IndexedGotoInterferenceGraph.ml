module IGto = IndexedGotoAST
module IGtoL = IndexedGotoLiveness
open CommonAST

let liveness = ref {live_in = Array.make 1 [];
					live_out = Array.make 1 []}

let rec add_interferences g i sl =
	match i with
	| (n,Sequence(i1,i2))			-> 	let g = add_interferences g i1 sl in
										add_interferences g i2 sl
	| (n,Block(i1,vl))				-> 	add_interferences g i1 (vl::sl)
	| (n,Set(Identifier(Id(u)),Location(Identifier(Id(v)))))
									-> 	List.fold_left (fun g s -> if s <> v then Graph.add_edge g u s) g !liveness.live_out.(n)
	| (n,Set(Identifier(Id(u)),_)) 	-> 	List.fold_left (fun g s -> Graph.add_edge g u s) g !liveness.live_out.(n)
	| (n,_)							-> 	g


let interference_graph fi =
	let g,sl = Symb_Tbl.fold (fun key value (g,l) -> (Graph.add_node g key,key::l)) fi.locals (Graph.empty,[]) in
	liveness := IGtoL.liveness fi.code;
	add_interferences g i sl