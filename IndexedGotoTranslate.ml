open CommonAST
module Gto = GotoAST
module IGto = IndexedGotoAST

let counter = ref 0

let rec index_instruction i = 
  counter := !counter + 1;
  let value = !counter in
  let instr = (match i with
  | Gto.Sequence(i1,i2) 	-> 	let j1 = index_instruction i1 in
								let j2 = index_instruction i2 in
								IGto.Sequence(j1,j2)
  | Gto.Set(l,e)			->  IGto.Set(l,e)
  | Gto.Label(l)			->  IGto.Label(l)
  | Gto.Goto(l)				->  IGto.Goto(l)
  | Gto.ConditionalGoto(l,e)->  IGto.ConditionalGoto(l,e)
  | Gto.Nop					->  IGto.Nop
  | Gto.Jump(s,l)			->  IGto.Jump(s,l)
  | Gto.Return(e)			->  IGto.Return(e)
  | Gto.ProcCall(i,el)		-> 	IGto.ProcCall(i,el)
  | Gto.Block(i,vl)			->  IGto.Block(index_instruction i,vl)
  ) in (value,instr)
  
let index_program (p : Gto.program) =
  IGto.({ globals = Gto.(p.globals); 
    functions = Symb_Tbl.map (fun fi -> counter := -1; {signature = Gto.(fi.signature); code = (index_instruction Gto.(fi.code)); locals = Gto.(fi.locals); recursive = Gto.(fi.recursive)}) Gto.(p.functions)})

let rec strip_instruction (n,i) = match i with
  | IGto.Sequence(i1,i2) 		-> Gto.Sequence(strip_instruction i1, strip_instruction i2)
  | IGto.Set(l,e)				-> Gto.Set(l,e)
  | IGto.Goto(l)				-> Gto.Goto(l)
  | IGto.Label(l)				-> Gto.Label(l)
  | IGto.ConditionalGoto(l,e)	-> Gto.ConditionalGoto(l,e)
  | IGto.Nop					-> Gto.Nop
  | IGto.Jump(s,l)				-> Gto.Jump(s,l)
  | IGto.Return(e)				-> Gto.Return(e)
  | IGto.ProcCall(i,el)			-> Gto.ProcCall(i,el)
  | IGto.Block(i,vl)			-> Gto.Block(strip_instruction i,vl)
  
  
let strip_program (p : IGto.program) =
  Gto.({ globals = IGto.(p.globals);
    functions = Symb_Tbl.map (fun fi -> {signature = IGto.(fi.signature); code = (strip_instruction IGto.(fi.code)); locals = IGto.(fi.locals); recursive = IGto.(fi.recursive)}) IGto.(p.functions)})
