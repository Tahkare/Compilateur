open CommonAST

type value =
  | Location of location

and expression =
  | Literal  	of literal
  | UnaryOp  	of unaryOp  * value
  | BinaryOp 	of binaryOp * value * value
  | NewBlock 	of value * int
  | LabelAddr 	of label
  | FunCall  	of identifier * value list
  | TermFunCall	of identifier * value list

and location =
  | Identifier  of identifier
  | BlockAccess of value * value

  
and instruction =
  | Sequence        of instruction * instruction
  | FlatSet		    of location * expression
  | Set             of location * value
  | Label           of label
  | Goto            of label
  | ConditionalGoto of label * value
  | Nop
  | Jump			of string * location
  | Return			of value
  | ProcCall		of identifier * value list
  | TermProcCall	of identifier * value list
  | Block			of instruction * (string * typ) list

let (++) i1 i2 = Sequence(i1, i2)

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
