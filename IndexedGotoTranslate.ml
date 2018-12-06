open CommonAST
module Gto = GotoAST
module IGto = IndexedGotoAST

let counter = ref 0

let rec index_expression e = match e with
  | Gto.Literal(l)			-> IGto.Literal(l)
  | Gto.Location(l)			-> IGto.Location(index_location l)
  | Gto.UnaryOp(o,e)		-> IGto.UnaryOp(o, index_expression e)
  | Gto.BinaryOp(o,e1,e2) 	-> IGto.BinaryOp(o, index_expression e1, index_expression e2)
  | Gto.NewBlock(e,n)		-> IGto.NewBlock(index_expression e,n)
  | Gto.LabelAddr(l)		-> IGto.LabelAddr(l)
  | Gto.FunCall(i,el)		-> IGto.FunCall(i,List.map (fun x -> index_expression x) el)
  
and index_location l = match l with
  | Gto.Identifier(i)		-> IGto.Identifier(i)
  | Gto.BlockAccess(e1,e2)	-> IGto.BlockAccess(index_expression e1, index_expression e2)

let rec index_instruction i = 
  counter := !counter + 1;
  let value = !counter in
  let instr = (match i with
  | Gto.Sequence(i1,i2) 	->	let j1 = index_instruction i1 in
								let j2 = index_instruction i2 in
								IGto.Sequence(j1,j2)
  | Gto.Set(l,e)			->	IGto.Set(index_location l,index_expression e)
  | Gto.Label(l)			->	IGto.Label(l)
  | Gto.Goto(l)				->	IGto.Goto(l)
  | Gto.ConditionalGoto(l,e)->	IGto.ConditionalGoto(l,index_expression e)
  | Gto.Nop					->	IGto.Nop
  | Gto.Jump(s,l)			->	IGto.Jump(s,index_location l)
  | Gto.Return(e)			->	IGto.Return(index_expression e)
  | Gto.ProcCall(i,el)		->	IGto.ProcCall(i,List.map (fun x -> index_expression x) el)
  | Gto.Block(i,vl)			->	IGto.Block(index_instruction i,vl)
  ) in (value,instr)
  
let index_program (p : Gto.program) =
  IGto.({ globals = Gto.(p.globals); 
    functions = Symb_Tbl.map (fun fi -> counter := -1; {signature = Gto.(fi.signature); code = (index_instruction Gto.(fi.code)); locals = Gto.(fi.locals); recursive = Gto.(fi.recursive)}) Gto.(p.functions)})


let rec strip_expression e = match e with
  | IGto.Literal(l)			-> Gto.Literal(l)
  | IGto.Location(l)		-> Gto.Location(strip_location l)
  | IGto.UnaryOp(o,e)		-> Gto.UnaryOp(o, strip_expression e)
  | IGto.BinaryOp(o,e1,e2) 	-> Gto.BinaryOp(o, strip_expression e1, strip_expression e2)
  | IGto.NewBlock(e,n)		-> Gto.NewBlock(strip_expression e,n)
  | IGto.LabelAddr(l)		-> Gto.LabelAddr(l)
  | IGto.FunCall(i,el)		-> Gto.FunCall(i,List.map (fun x -> strip_expression x) el)
  
and strip_location l = match l with
  | IGto.Identifier(i)		-> Gto.Identifier(i)
  | IGto.BlockAccess(e1,e2)	-> Gto.BlockAccess(strip_expression e1, strip_expression e2)	
	
let rec strip_instruction (n,i) = match i with
  | IGto.Sequence(i1,i2) 		-> Gto.Sequence(strip_instruction i1, strip_instruction i2)
  | IGto.Set(l,e)				-> Gto.Set(strip_location l,strip_expression e)
  | IGto.Goto(l)				-> Gto.Goto(l)
  | IGto.Label(l)				-> Gto.Label(l)
  | IGto.ConditionalGoto(l,e)	-> Gto.ConditionalGoto(l,strip_expression e)
  | IGto.Nop					-> Gto.Nop
  | IGto.Jump(s,l)				-> Gto.Jump(s,strip_location l)
  | IGto.Return(e)				-> Gto.Return(strip_expression e)
  | IGto.ProcCall(i,el)			-> Gto.ProcCall(i,List.map (fun x -> strip_expression x) el)
  | IGto.Block(i,vl)			-> Gto.Block(strip_instruction i,vl)
  
  
let strip_program (p : IGto.program) =
  Gto.({ globals = IGto.(p.globals);
    functions = Symb_Tbl.map (fun fi -> {signature = IGto.(fi.signature); code = (strip_instruction IGto.(fi.code)); locals = IGto.(fi.locals); recursive = IGto.(fi.recursive)}) IGto.(p.functions)})
