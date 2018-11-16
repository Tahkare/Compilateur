{

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
        
}

(* Raccourci : caractères alphabétiques *)
let alpha = ['a'-'z' 'A'-'Z' '_' '0'-'9']
let digit = ['0'-'9']

(* Expressions régulières définissant les lexèmes *)
rule token = parse
  (* Les espaces sont ignorés *)
  | ' '
      { chars := !chars+1; token lexbuf }
  | '\t'
	  { chars := !chars+4; token lexbuf }
  | '\n'
      { lines := !lines+1; chars := 1; new_line lexbuf; token lexbuf }
  | '\r'
	  { chars := !chars+1; token lexbuf }
  (* Les chaînes alphabétiques sont traitées par la fonction [id_or_keyword]
     pour être associées à des mots-clés ou des identifiants. *)
  | ['a'-'z' 'A'-'Z']alpha*
      { chars := !chars+(lexeme_end lexbuf)-(lexeme_start lexbuf); id_or_keyword (lexeme lexbuf) }
  (* Début et fin de bloc *)
  | "{"
      { chars := !chars+1; BEGIN }
  | "}"
      { chars := !chars+1; END }
  (* Crochets pour les tableaux *)
  | "["
      { chars := !chars+1; LC }
  | "]"
      { chars := !chars+1; RC }
  (* Entiers *)
  | digit+
	  { chars := !chars+(lexeme_end lexbuf)-(lexeme_start lexbuf); CONST_INT (int_of_string(lexeme lexbuf)) }
  (* Opérateurs *)
  | "->"
      { chars := !chars+2; ARROW }
  | "+"
	  { chars := !chars+1; PLUS }
  | "-"
	  { chars := !chars+1; MINUS }
  | "*"
	  { chars := !chars+1; STAR }
  | "/"
	  { chars := !chars+1; DIV }
  | "%"
	  { chars := !chars+1; MOD }
  | "=="
	  { chars := !chars+2; EQUAL }
  | "="
	  { chars := !chars+1; SET_INIT }
  | "!="
	  { chars := !chars+2; NEQ }
  | "<="
	  { chars := !chars+2; LE }
  | "<"
	  { chars := !chars+1; LT }
  | ">="
	  { chars := !chars+2; GE }
  | ">"
	  { chars := !chars+1; GT }
  | "!"
	  { chars := !chars+1; NOT }
  | "&&"
	  { chars := !chars+2; AND }
  | "||"
	  { chars := !chars+2; OR }
  | "."
	  { chars := !chars+1; DOT }
  (* Parenthèses *)
  | "("
	  { chars := !chars+1; LP }
  | ")"
	  { chars := !chars+1; RP }
  (* Affectation *)
  | ":="
	  { chars := !chars+2; SET }
  (* Deux points *)
  | ":"
	  { chars := !chars+1; COLON }
  (* Délimiteurs *)
  | ";"
	  { chars := !chars+1; SEMI }
  | ","
	  { chars := !chars+1; COMMA }
  (* Commentaires avec une variable qui indique si le commentaire est multi-lignes ou pas *)
  | "//"
	  { chars := !chars+2; comment false lexbuf }
  | "/*"
	  { chars := !chars+2; comment true lexbuf }
  (* Fin de fichier *)
  | eof
      { EOF }
  (* Caractères non reconnus *)
  | _
      { failwith ("Unknown character : " ^ (lexeme lexbuf) ^ " on line " ^ string_of_int(!lines) ^ " at position " ^ string_of_int(!chars)) }

and comment multi = parse
  | '\n'
      { lines := !lines+1; chars := 1; if multi then comment multi lexbuf else token lexbuf }
  | "*/"
      { chars := !chars+2; if multi then token lexbuf else comment multi lexbuf }
  | eof
      { if multi then failwith ("Reached end of file before comment was closed") else EOF }
  | _
	  { chars := !chars+1; comment multi lexbuf }
