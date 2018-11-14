type identifier = Id  of string
type label      = Lab of string

module Symb_Tbl = Map.Make(String)
    
type typ =
  | TypInt
  | TypBool
  | TypArray of typ
  | TypStruct of string
  | TypVoid
  | TypAny

type sub_struct_type = { fields: (string * typ * bool) list; }
type struct_type = (string * sub_struct_type)

type function_signature = {
  return : typ;
  formals: (string * typ) list;
}

type type_context = {
  identifier_types: typ Symb_Tbl.t;
  struct_types: struct_type Symb_Tbl.t;
  union_lists: (string list) Symb_Tbl.t;
  function_signatures: function_signature Symb_Tbl.t;
}

type literal =
  | Int  of int
  | Bool of bool

type unaryOp = Minus | Not
    
type binaryOp = Add | Sub | Mult | Div | Mod
                | Eq | Neq | Lt | Le | Gt | Ge
                | And | Or
				| LEq
