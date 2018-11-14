# 1 "SourceIndentLexer.mll"
 

  (* Contexte *)
  open Lexing
  open SourceParser
  
  (* Compteurs de position *)
  let lines = ref 1
  let chars = ref 1
  
  (* Booléen qui indique si on regarde l'indentation de début de ligne ou pas *)
  let line_started = ref true
  
  (* Indentation de la ligne précédente *)
  let prev_indent = ref 0
  
  (* Stocke pour chaque indentation si c'est un if ou non. Si c'est un if, on ne pourra jamais avoir de ; après } *)
  let indent_as_if = ref ([] : bool list)
  
  (* Booléen qui passe à true quand on rencontre un if pour le stockage dans la liste *)
  let is_next_if = ref false
  
  (* Booléen qui passe à true quand on vient de renvoyer } et qu'on attend ; juste après *)
  let need_semi = ref false

  (* Traitement des chaînes de caractères alphabétiques *)
  let id_or_keyword =
    (* Définition d'une table des mots-clés et des lexèmes associés *)
    let h = Hashtbl.create 17 in
    List.iter (fun (s, k) -> Hashtbl.add h s k)
      [	"main", MAIN; "true", CONST_BOOL(true); "false", CONST_BOOL(false); "boolean", BOOLEAN; "integer", INTEGER;
	    "if", IF; "else", ELSE; "print", PRINT; "var", VAR; "while", WHILE; "for", FOR; "break", BREAK;
		"continue", CONTINUE
      ] ;
    fun s ->
      (* On cherche la chaîne [s] dans la table. Si on trouve un mot-clé alors
         on le renvoie. *)
      try  Hashtbl.find h s
      (* Et sinon on considère qu'il s'agit d'un identifiant. *)
      with Not_found -> IDENT(s)
        

# 45 "SourceIndentLexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\255\255\000\000\001\000\230\255\231\255\234\255\003\000\236\255\
    \237\255\000\000\002\000\004\000\031\000\032\000\033\000\247\255\
    \084\000\249\255\250\255\251\255\084\000\077\000\254\255\003\000\
    \232\255\233\255\246\255\245\255\244\255\242\255\239\255\238\255\
    \235\255\005\000\252\255\253\255\013\000\255\255\254\255";
  Lexing.lex_backtrk = 
   "\255\255\000\000\000\000\255\255\255\255\255\255\025\000\255\255\
    \255\255\025\000\025\000\014\000\012\000\015\000\025\000\255\255\
    \007\000\255\255\255\255\255\255\003\000\002\000\255\255\000\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\003\000\255\255\255\255";
  Lexing.lex_default = 
   "\000\000\255\255\003\000\000\000\000\000\000\000\255\255\000\000\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\000\000\
    \255\255\000\000\000\000\000\000\255\255\255\255\000\000\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\034\000\000\000\000\000\255\255\000\000\000\000";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\001\000\023\000\022\000\023\000\001\000\023\000\037\000\
    \023\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \001\000\023\000\013\000\023\000\000\000\000\000\015\000\010\000\
    \030\000\008\000\007\000\017\000\019\000\005\000\018\000\036\000\
    \016\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\006\000\038\000\012\000\014\000\011\000\
    \032\000\029\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\028\000\027\000\026\000\000\000\
    \000\000\000\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\031\000\009\000\024\000\000\000\
    \000\000\000\000\000\000\025\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\004\000\000\000\000\000\000\000\035\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\001\000\002\000\002\000\023\000\001\000\002\000\033\000\
    \023\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \001\000\002\000\002\000\023\000\255\255\255\255\002\000\002\000\
    \010\000\002\000\002\000\002\000\002\000\002\000\002\000\033\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\036\000\002\000\002\000\002\000\
    \006\000\011\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\012\000\013\000\014\000\255\255\
    \255\255\255\255\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\009\000\002\000\016\000\255\255\
    \255\255\255\255\255\255\016\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\002\000\255\255\255\255\255\255\033\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255";
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
# 53 "SourceIndentLexer.mll"
 ( if !need_semi then begin need_semi := false; SEMI end else linestart lexbuf )
# 174 "SourceIndentLexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_token_rec lexbuf __ocaml_lex_state

and linestart lexbuf =
    __ocaml_lex_linestart_rec lexbuf 1
and __ocaml_lex_linestart_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 58 "SourceIndentLexer.mll"
      ( let l = (String.length (lexeme lexbuf)) in 
	    chars := !chars+l; 
		if not !line_started then begin
		  line_started := true;
		  if l > !prev_indent then begin 
		    indent_as_if := (!is_next_if::!indent_as_if);
			is_next_if := false; 
			prev_indent := l; 
			BEGIN
		  end
		  else if l== !prev_indent then begin 
		    SEMI 
		  end
		  else begin
		    need_semi := not (List.hd !indent_as_if);
			indent_as_if := (List.tl !indent_as_if);
			prev_indent := l;
			END
		  end
		end
		else main lexbuf )
# 206 "SourceIndentLexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_linestart_rec lexbuf __ocaml_lex_state

and main lexbuf =
    __ocaml_lex_main_rec lexbuf 2
and __ocaml_lex_main_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 84 "SourceIndentLexer.mll"
      ( chars := !chars+(lexeme_end lexbuf)-(lexeme_start lexbuf); main lexbuf )
# 218 "SourceIndentLexer.ml"

  | 1 ->
# 86 "SourceIndentLexer.mll"
      ( lines := !lines+1; chars := 1; line_started := false; new_line lexbuf; token lexbuf )
# 223 "SourceIndentLexer.ml"

  | 2 ->
# 90 "SourceIndentLexer.mll"
      ( line_started := true; chars := !chars+(lexeme_end lexbuf)-(lexeme_start lexbuf); let word = id_or_keyword (lexeme lexbuf) in 
		if word == IF then is_next_if := true; word)
# 229 "SourceIndentLexer.ml"

  | 3 ->
# 94 "SourceIndentLexer.mll"
   ( chars := !chars+(lexeme_end lexbuf)-(lexeme_start lexbuf); CONST_INT (int_of_string(lexeme lexbuf)) )
# 234 "SourceIndentLexer.ml"

  | 4 ->
# 97 "SourceIndentLexer.mll"
   ( chars := !chars+1; PLUS )
# 239 "SourceIndentLexer.ml"

  | 5 ->
# 99 "SourceIndentLexer.mll"
   ( chars := !chars+1; MINUS )
# 244 "SourceIndentLexer.ml"

  | 6 ->
# 101 "SourceIndentLexer.mll"
   ( chars := !chars+1; STAR )
# 249 "SourceIndentLexer.ml"

  | 7 ->
# 103 "SourceIndentLexer.mll"
   ( chars := !chars+1; DIV )
# 254 "SourceIndentLexer.ml"

  | 8 ->
# 105 "SourceIndentLexer.mll"
   ( chars := !chars+1; MOD )
# 259 "SourceIndentLexer.ml"

  | 9 ->
# 107 "SourceIndentLexer.mll"
   ( chars := !chars+2; EQUAL )
# 264 "SourceIndentLexer.ml"

  | 10 ->
# 109 "SourceIndentLexer.mll"
   ( chars := !chars+2; NEQ )
# 269 "SourceIndentLexer.ml"

  | 11 ->
# 111 "SourceIndentLexer.mll"
   ( chars := !chars+2; LE )
# 274 "SourceIndentLexer.ml"

  | 12 ->
# 113 "SourceIndentLexer.mll"
   ( chars := !chars+1; LT )
# 279 "SourceIndentLexer.ml"

  | 13 ->
# 115 "SourceIndentLexer.mll"
   ( chars := !chars+2; GE )
# 284 "SourceIndentLexer.ml"

  | 14 ->
# 117 "SourceIndentLexer.mll"
   ( chars := !chars+1; GT )
# 289 "SourceIndentLexer.ml"

  | 15 ->
# 119 "SourceIndentLexer.mll"
   ( chars := !chars+1; NOT )
# 294 "SourceIndentLexer.ml"

  | 16 ->
# 121 "SourceIndentLexer.mll"
   ( chars := !chars+2; AND )
# 299 "SourceIndentLexer.ml"

  | 17 ->
# 123 "SourceIndentLexer.mll"
   ( chars := !chars+2; OR )
# 304 "SourceIndentLexer.ml"

  | 18 ->
# 126 "SourceIndentLexer.mll"
   ( chars := !chars+1; LP )
# 309 "SourceIndentLexer.ml"

  | 19 ->
# 128 "SourceIndentLexer.mll"
   ( chars := !chars+1; RP )
# 314 "SourceIndentLexer.ml"

  | 20 ->
# 131 "SourceIndentLexer.mll"
   ( chars := !chars+2; SET )
# 319 "SourceIndentLexer.ml"

  | 21 ->
# 134 "SourceIndentLexer.mll"
   ( chars := !chars+1; COMMA )
# 324 "SourceIndentLexer.ml"

  | 22 ->
# 137 "SourceIndentLexer.mll"
   ( chars := !chars+2; comment false lexbuf )
# 329 "SourceIndentLexer.ml"

  | 23 ->
# 139 "SourceIndentLexer.mll"
   ( chars := !chars+2; comment true lexbuf )
# 334 "SourceIndentLexer.ml"

  | 24 ->
# 142 "SourceIndentLexer.mll"
      ( match !indent_as_if with
		| [] -> EOF
		| hd::tl -> indent_as_if := (List.tl !indent_as_if); END)
# 341 "SourceIndentLexer.ml"

  | 25 ->
# 147 "SourceIndentLexer.mll"
      ( failwith ("Unknown character : " ^ (lexeme lexbuf) ^ " on line " ^ string_of_int(!lines) ^ " at position " ^ string_of_int(!chars)) )
# 346 "SourceIndentLexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_main_rec lexbuf __ocaml_lex_state

and comment multi lexbuf =
    __ocaml_lex_comment_rec multi lexbuf 33
and __ocaml_lex_comment_rec multi lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 151 "SourceIndentLexer.mll"
      ( lines := !lines+1; 
	    chars := 1; 
		if multi then comment multi lexbuf 
		else begin line_started := false; main lexbuf end )
# 361 "SourceIndentLexer.ml"

  | 1 ->
# 156 "SourceIndentLexer.mll"
      ( chars := !chars+2; if multi then main lexbuf else comment multi lexbuf )
# 366 "SourceIndentLexer.ml"

  | 2 ->
# 158 "SourceIndentLexer.mll"
      ( if multi then failwith ("Reached end of file before comment was closed") else EOF )
# 371 "SourceIndentLexer.ml"

  | 3 ->
# 160 "SourceIndentLexer.mll"
   ( chars := !chars+1; comment multi lexbuf )
# 376 "SourceIndentLexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_comment_rec multi lexbuf __ocaml_lex_state

;;

