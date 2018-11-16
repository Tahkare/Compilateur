# 1 "SourceLexer.mll"
 

  (* Contexte *)
  open Lexing
  open SourceParser
  
  (* Compteurs de position *)
  let lines = ref 1
  let chars = ref 1

  (* Traitement des chaînes de caractères alphabétiques *)
  let id_or_keyword =
    (* Définition d'une table des mots-clés et des lexèmes associés *)
    let h = Hashtbl.create 17 in
    List.iter (fun (s, k) -> Hashtbl.add h s k)
      [	"main", MAIN; "true", CONST_BOOL(true); "false", CONST_BOOL(false); "boolean", BOOLEAN; "integer", INTEGER;
	    "if", IF; "else", ELSE; "var", VAR; "while", WHILE; "for", FOR; "break", BREAK;
		"continue", CONTINUE; "elif", ELIF; "new", NEW; "struct", STRUCT; "immutable", IMMUTABLE; "union", UNION;
        "switch", SWITCH; "case", CASE; "default", DEFAULT; "return", RETURN; "fun", FUN;
      ] ;
    fun s ->
      (* On cherche la chaîne [s] dans la table. Si on trouve un mot-clé alors
         on le renvoie. *)
      try  Hashtbl.find h s
      (* Et sinon on considère qu'il s'agit d'un identifiant. *)
      with Not_found -> IDENT(s)
        

# 31 "SourceLexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\219\255\220\255\223\255\224\255\002\000\227\255\228\255\
    \229\255\002\000\001\000\003\000\031\000\033\000\034\000\240\255\
    \085\000\242\255\244\255\034\000\085\000\247\255\248\255\249\255\
    \250\255\095\000\252\255\253\255\254\255\255\255\245\255\221\255\
    \222\255\239\255\237\255\236\255\234\255\231\255\230\255\226\255\
    \144\000\252\255\253\255\081\000\255\255\254\255";
  Lexing.lex_backtrk = 
   "\255\255\255\255\255\255\255\255\255\255\030\000\255\255\255\255\
    \255\255\036\000\036\000\022\000\020\000\023\000\017\000\255\255\
    \014\000\255\255\255\255\012\000\009\000\255\255\255\255\255\255\
    \255\255\004\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\003\000\255\255\255\255";
  Lexing.lex_default = 
   "\001\000\000\000\000\000\000\000\000\000\255\255\000\000\000\000\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\000\000\
    \255\255\000\000\000\000\255\255\255\255\000\000\000\000\000\000\
    \000\000\255\255\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \041\000\000\000\000\000\255\255\000\000\000\000";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\028\000\027\000\000\000\000\000\026\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \029\000\013\000\000\000\000\000\000\000\015\000\010\000\037\000\
    \007\000\006\000\017\000\018\000\003\000\019\000\008\000\016\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\005\000\004\000\012\000\014\000\011\000\039\000\
    \036\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\022\000\035\000\021\000\034\000\033\000\
    \030\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\024\000\009\000\023\000\038\000\031\000\
    \045\000\000\000\000\000\000\000\032\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\000\000\044\000\000\000\000\000\000\000\000\000\000\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\043\000\000\000\000\000\000\000\025\000\000\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \042\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\255\255\255\255\000\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\255\255\255\255\255\255\000\000\000\000\010\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\005\000\
    \011\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\012\000\000\000\013\000\014\000\
    \019\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\009\000\016\000\
    \043\000\255\255\255\255\255\255\016\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\255\255\040\000\255\255\255\255\255\255\255\255\255\255\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\040\000\255\255\255\255\255\255\025\000\255\255\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\025\000\025\000\025\000\025\000\025\000\025\000\
    \025\000\025\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \040\000";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec token lexbuf =
    __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 38 "SourceLexer.mll"
      ( chars := !chars+1; token lexbuf )
# 179 "SourceLexer.ml"

  | 1 ->
# 40 "SourceLexer.mll"
   ( chars := !chars+4; token lexbuf )
# 184 "SourceLexer.ml"

  | 2 ->
# 42 "SourceLexer.mll"
      ( lines := !lines+1; chars := 1; new_line lexbuf; token lexbuf )
# 189 "SourceLexer.ml"

  | 3 ->
# 44 "SourceLexer.mll"
   ( chars := !chars+1; token lexbuf )
# 194 "SourceLexer.ml"

  | 4 ->
# 48 "SourceLexer.mll"
      ( chars := !chars+(lexeme_end lexbuf)-(lexeme_start lexbuf); id_or_keyword (lexeme lexbuf) )
# 199 "SourceLexer.ml"

  | 5 ->
# 51 "SourceLexer.mll"
      ( chars := !chars+1; BEGIN )
# 204 "SourceLexer.ml"

  | 6 ->
# 53 "SourceLexer.mll"
      ( chars := !chars+1; END )
# 209 "SourceLexer.ml"

  | 7 ->
# 56 "SourceLexer.mll"
      ( chars := !chars+1; LC )
# 214 "SourceLexer.ml"

  | 8 ->
# 58 "SourceLexer.mll"
      ( chars := !chars+1; RC )
# 219 "SourceLexer.ml"

  | 9 ->
# 61 "SourceLexer.mll"
   ( chars := !chars+(lexeme_end lexbuf)-(lexeme_start lexbuf); CONST_INT (int_of_string(lexeme lexbuf)) )
# 224 "SourceLexer.ml"

  | 10 ->
# 64 "SourceLexer.mll"
      ( chars := !chars+2; ARROW )
# 229 "SourceLexer.ml"

  | 11 ->
# 66 "SourceLexer.mll"
   ( chars := !chars+1; PLUS )
# 234 "SourceLexer.ml"

  | 12 ->
# 68 "SourceLexer.mll"
   ( chars := !chars+1; MINUS )
# 239 "SourceLexer.ml"

  | 13 ->
# 70 "SourceLexer.mll"
   ( chars := !chars+1; STAR )
# 244 "SourceLexer.ml"

  | 14 ->
# 72 "SourceLexer.mll"
   ( chars := !chars+1; DIV )
# 249 "SourceLexer.ml"

  | 15 ->
# 74 "SourceLexer.mll"
   ( chars := !chars+1; MOD )
# 254 "SourceLexer.ml"

  | 16 ->
# 76 "SourceLexer.mll"
   ( chars := !chars+2; EQUAL )
# 259 "SourceLexer.ml"

  | 17 ->
# 78 "SourceLexer.mll"
   ( chars := !chars+1; SET_INIT )
# 264 "SourceLexer.ml"

  | 18 ->
# 80 "SourceLexer.mll"
   ( chars := !chars+2; NEQ )
# 269 "SourceLexer.ml"

  | 19 ->
# 82 "SourceLexer.mll"
   ( chars := !chars+2; LE )
# 274 "SourceLexer.ml"

  | 20 ->
# 84 "SourceLexer.mll"
   ( chars := !chars+1; LT )
# 279 "SourceLexer.ml"

  | 21 ->
# 86 "SourceLexer.mll"
   ( chars := !chars+2; GE )
# 284 "SourceLexer.ml"

  | 22 ->
# 88 "SourceLexer.mll"
   ( chars := !chars+1; GT )
# 289 "SourceLexer.ml"

  | 23 ->
# 90 "SourceLexer.mll"
   ( chars := !chars+1; NOT )
# 294 "SourceLexer.ml"

  | 24 ->
# 92 "SourceLexer.mll"
   ( chars := !chars+2; AND )
# 299 "SourceLexer.ml"

  | 25 ->
# 94 "SourceLexer.mll"
   ( chars := !chars+2; OR )
# 304 "SourceLexer.ml"

  | 26 ->
# 96 "SourceLexer.mll"
   ( chars := !chars+1; DOT )
# 309 "SourceLexer.ml"

  | 27 ->
# 99 "SourceLexer.mll"
   ( chars := !chars+1; LP )
# 314 "SourceLexer.ml"

  | 28 ->
# 101 "SourceLexer.mll"
   ( chars := !chars+1; RP )
# 319 "SourceLexer.ml"

  | 29 ->
# 104 "SourceLexer.mll"
   ( chars := !chars+2; SET )
# 324 "SourceLexer.ml"

  | 30 ->
# 107 "SourceLexer.mll"
   ( chars := !chars+1; COLON )
# 329 "SourceLexer.ml"

  | 31 ->
# 110 "SourceLexer.mll"
   ( chars := !chars+1; SEMI )
# 334 "SourceLexer.ml"

  | 32 ->
# 112 "SourceLexer.mll"
   ( chars := !chars+1; COMMA )
# 339 "SourceLexer.ml"

  | 33 ->
# 115 "SourceLexer.mll"
   ( chars := !chars+2; comment false lexbuf )
# 344 "SourceLexer.ml"

  | 34 ->
# 117 "SourceLexer.mll"
   ( chars := !chars+2; comment true lexbuf )
# 349 "SourceLexer.ml"

  | 35 ->
# 120 "SourceLexer.mll"
      ( EOF )
# 354 "SourceLexer.ml"

  | 36 ->
# 123 "SourceLexer.mll"
      ( failwith ("Unknown character : " ^ (lexeme lexbuf) ^ " on line " ^ string_of_int(!lines) ^ " at position " ^ string_of_int(!chars)) )
# 359 "SourceLexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_token_rec lexbuf __ocaml_lex_state

and comment multi lexbuf =
    __ocaml_lex_comment_rec multi lexbuf 40
and __ocaml_lex_comment_rec multi lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 127 "SourceLexer.mll"
      ( lines := !lines+1; chars := 1; if multi then comment multi lexbuf else token lexbuf )
# 371 "SourceLexer.ml"

  | 1 ->
# 129 "SourceLexer.mll"
      ( chars := !chars+2; if multi then token lexbuf else comment multi lexbuf )
# 376 "SourceLexer.ml"

  | 2 ->
# 131 "SourceLexer.mll"
      ( if multi then failwith ("Reached end of file before comment was closed") else EOF )
# 381 "SourceLexer.ml"

  | 3 ->
# 133 "SourceLexer.mll"
   ( chars := !chars+1; comment multi lexbuf )
# 386 "SourceLexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_comment_rec multi lexbuf __ocaml_lex_state

;;

