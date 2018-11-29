open CommonAST
module Gto = GotoAST

let counter = ref 0
   
type instruction = int * instruction_descr 
   
and instruction_descr =
  | Sequence        of instruction * instruction
  | Set             of location * expression
  | Label           of label
  | Goto            of label
  | ConditionalGoto of label * expression
  | Nop
  | Jump			of string * location
  | Return			of expression
  | ProcCall		of identifier * expression list
  | Block			of instruction * (string * typ) list

type function_info = {
  signature : function_signature;
  code : instruction;
  locals : typ Symb_Tbl.t;
  recursive : bool;
}

type program = {
  globals: typ Symb_Tbl.t;
  functions : function_info Symb_Tbl.t;
}

let index_instruction i = 
  counter := !counter + 1;
  let value = !counter in
  let instr = (match i with
  | Gto.Sequence(i1,i2) 	-> 	let j1 = index_instruction i1 in
								let j2 = index_instruction i2 in
								Sequence(j1,j2)
  | Gto.Set(l,e)			->  Set(l,e)
  | Gto.Label(l)			->  Label(l)
  | Gto.Goto(l)				->  Goto(l)
  | Gto.ConditionalGoto(l)	->  ConditionalGoto(l)
  | Gto.Nop					->  Nop
  | Gto.Jump(s,l)			->  Jump(s,l)
  | Gto.Return(e)			->  Return(e)
  | Gto.ProcCall(i,el)		-> 	ProcCall(i,el)
  | Gto.Block(i,vl)			->  Block(index_instruction i,vl)
  ) in (value,instr)
  
let index_program p =
  { globals = p.globals; 
    functions = Symb_Tbl.map (fun fi -> !counter := -1; {signature = fi.signature; code = index_instruction fi.code; locals = fi.locals; recusive = fi.recursive}) p.functions}

let strip_instruction (n,i) = match i with
  | Sequence(i1,i2) 		-> Gto.Sequence(strip_instruction i1, strip_instruction i2)
  | Set(l,e)				-> Gto.Set(l,e)
  | Goto(l)					-> Gto.Goto(l)
  | Label(l)				-> Gto.Label(l)
  | ConditionalGoto(l,e)	-> Gto.ConditionalGoto(l,e)
  | Nop						-> Gto.Nop
  | Jump(s,l)				-> Gto.Jump(s,l)
  | Return(e)				-> Gto.Return(e)
  | ProcCall(i,el)			-> Gto.ProcCall(i,el)
  | Block(i,vl)				-> Gto.Block(strip_instruction i,vl)
  
  
let strip_program p =
  { globals = p.globals;
    functions = Symb_Tbl.map (fun fi -> {signature = fi.signature; code = strip_instruction fi.code; locals = fi.locals; recusive = fi.recursive}) p.functions}