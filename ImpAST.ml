open CommonAST

type expression =
  | Literal  of literal
  | Location of location
  | UnaryOp  of unaryOp  * expression
  | BinaryOp of binaryOp * expression * expression
  | NewBlock of expression * int
  | FunCall  of identifier * expression list

and location =
  | Identifier  of identifier
  | BlockAccess of expression * expression

and typed_instruction = {
	instr : instruction;
	locals : typ Symb_Tbl.t;
}

and instruction =
  | Set         of location   * expression
  | Conditional of expression * typed_instruction * typed_instruction
  | Loop        of expression * typed_instruction
  | Sequence    of typed_instruction * typed_instruction
  | For			of typed_instruction * expression * typed_instruction * typed_instruction
  | Nop
  | Break
  | Continue
  | Switch		of string * location * ((expression * typed_instruction) list)
  | Return		of expression
  | ProcCall	of identifier * expression list

type function_info = {
  signature : function_signature;
  code : typed_instruction;
  locals : typ Symb_Tbl.t;
  recursive : bool;
}
  
type program = {
  globals: typ Symb_Tbl.t;
  functions : function_info Symb_Tbl.t;
}
