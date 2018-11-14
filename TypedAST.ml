open CommonAST

type typed_expression = {
  expr : expression;
  t : typ;
} 

and expression =
  | Literal  of literal
  | Location of typed_location
  | UnaryOp  of unaryOp  * typed_expression
  | BinaryOp of binaryOp * typed_expression * typed_expression
  | NewArray of typed_expression
  | NewRecord of string
  | FunCall  of identifier * typed_expression list

and  typed_location = {
  loc : location;
  lt : typ;
} 
  
and location =
  | Identifier  of identifier
  | ArrayAccess of typed_expression * typed_expression
  | FieldAccess of typed_expression * string

and typed_instruction = {
  instr : instruction;
  locals : typ Symb_Tbl.t;
}  
  
and instruction =
  | Set         of typed_location * typed_expression
  | Conditional of typed_expression * typed_instruction
                                    * typed_instruction
  | Loop        of typed_expression * typed_instruction
  | Sequence    of typed_instruction * typed_instruction
  | For			of typed_instruction * typed_expression * typed_instruction * typed_instruction
  | Break
  | Continue
  | Nop
  | Switch		of string * typed_location * (string * typed_instruction) list
  | Return		of typed_expression
  | ProcCall	of identifier * typed_expression list
  
type function_info = {
  signature : function_signature;
  code : typed_instruction;
  locals : typ Symb_Tbl.t;
  recursive : bool;
}
  
type program = {
  globals: typ Symb_Tbl.t;
  structs: struct_type Symb_Tbl.t;
  union: (string list) Symb_Tbl.t;
  functions: function_info Symb_Tbl.t;
}
