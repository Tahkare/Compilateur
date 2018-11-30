open CommonAST
module Gto = GotoAST
  
type instruction = int * instruction_descr 
   
and instruction_descr =
  | Sequence        of instruction * instruction
  | Set             of Gto.location * Gto.expression
  | Label           of label
  | Goto            of label
  | ConditionalGoto of label * Gto.expression
  | Nop
  | Jump			of string * Gto.location
  | Return			of Gto.expression
  | ProcCall		of identifier * Gto.expression list
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
