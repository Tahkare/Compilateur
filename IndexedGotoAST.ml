open CommonAST
  
type instruction = int * instruction_descr 

and expression =
  | Literal  of literal
  | Location of location
  | UnaryOp  of unaryOp  * expression
  | BinaryOp of binaryOp * expression * expression
  | NewBlock of expression * int
  | LabelAddr of label
  | FunCall  of identifier * expression list

and location =
  | Identifier  of identifier
  | BlockAccess of expression * expression 
   
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
