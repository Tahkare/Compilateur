open CommonAST

type localised_expression = {
  expr : expression;
  e_pos : int * int;
}

and expression =
  | Literal  of literal
  | Location of location
  | UnaryOp  of unaryOp  * localised_expression
  | BinaryOp of binaryOp * localised_expression * localised_expression
  | NewArray of localised_expression * typ
  | NewRecord of string
  | FunCall  of identifier * localised_expression list

and location =
  | Identifier  of identifier
  | ArrayAccess of localised_expression * localised_expression
  | FieldAccess of localised_expression * string

let mk_expr expr l c = { expr = expr; e_pos = l, c }

type localised_instruction = {
  instr : instruction;
  locals : typ Symb_Tbl.t;
  i_pos : int * int;
}

and instruction =
  | Set         of location * localised_expression
  | InitSet		of location * localised_expression
  | Conditional of localised_expression * localised_instruction
                                        * localised_instruction
  | Loop        of localised_expression * localised_instruction
  | Sequence    of localised_instruction * localised_instruction
  | For			of localised_instruction * localised_expression * localised_instruction * localised_instruction
  | Break
  | Continue
  | Nop
  | Switch		of string * location * (string * localised_instruction) list
  | Return 	 	of localised_expression
  | ProcCall 	of identifier * localised_expression list
  | TypeCheck	of localised_expression * localised_expression
  
let mk_instr instr vars l c = { instr = instr; locals = vars; i_pos = l, c }

type function_info = {
  signature : function_signature;
  code : localised_instruction;
  locals : typ Symb_Tbl.t;
}	

type program = {
  globals: typ Symb_Tbl.t;
  structs: struct_type Symb_Tbl.t;
  union: (string list) Symb_Tbl.t;
  functions: function_info Symb_Tbl.t;
}
