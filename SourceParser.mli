
(* The type of tokens. *)

type token = 
  | WHILE
  | VAR
  | UNION
  | SWITCH
  | STRUCT
  | STAR
  | SET_INIT
  | SET
  | SEMI
  | RP
  | RETURN
  | RC
  | PLUS
  | OR
  | NOT
  | NEW
  | NEQ
  | MOD
  | MINUS
  | MAIN
  | LT
  | LP
  | LE
  | LC
  | INTEGER
  | IMMUTABLE
  | IF
  | IDENT of (string)
  | GT
  | GE
  | FUN
  | FOR
  | EQUAL
  | EOF
  | END
  | ELSE
  | ELIF
  | DOT
  | DIV
  | DEFAULT
  | CONTINUE
  | CONST_INT of (int)
  | CONST_BOOL of (bool)
  | COMMA
  | COLON
  | CASE
  | BREAK
  | BOOLEAN
  | BEGIN
  | ARROW
  | AND

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (SourceLocalisedAST.program)
