open CommonAST
module NodeMap = Map.Make(String)

type color = int
type coloring = color NodeMap.t

let rec pick_color g c s =
	let nl = Graph.neighbours g s in
	let cl = List.fold_left (fun acc x -> (NodeMap.find x c)::acc) [] nl in
	let n,b = List.fold_left (fun (n,b) x -> if b then (n,b) else if n <> x then (n,true) else (n+1,false)) (0,false) cl in
	if b then n else n+1

let rec colorize g =
	let s = Graph.min_degree g in
	match s with
	| Some(s) 	-> 	let g1 = Graph.del_node g s in
					let c = colorize g1 in
					let col = pick_color g c s in
					NodeMap.add s col c
	| None		-> 	NodeMap.empty