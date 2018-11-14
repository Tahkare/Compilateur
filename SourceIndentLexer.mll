{

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
	    "if", IF; "else", ELSE; "var", VAR; "while", WHILE; "for", FOR; "break", BREAK;
		"continue", CONTINUE; "elif", ELIF; "new", NEW; "struct", STRUCT; "immutable", IMMUTABLE; "union", UNION;
        "switch", SWITCH; "case", CASE; "default", DEFAULT; "return", RETURN;
      ] ;
    fun s ->
      (* On cherche la chaîne [s] dans la table. Si on trouve un mot-clé alors
         on le renvoie. *)
      try  Hashtbl.find h s
      (* Et sinon on considère qu'il s'agit d'un identifiant. *)
      with Not_found -> IDENT(s)
        
}

(* Raccourci : caractères alphabétiques et numériques *)
let alpha = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']

(* Expressions régulières définissant les lexèmes *)

(* Token va reconnaître un mot de 0 caractères. Si on a besoin de renvoyer un ; alors on le renvoie sinon, on passe à la reconnaissance normale *)
rule token = shortest
  | _?
	{ if !need_semi then begin need_semi := false; SEMI end else linestart lexbuf }

(* Cette règle gère l'indentation de début de ligne ou passe à la gestion du reste si ce n'est pas le cas *)
and linestart = parse	
  | [' ' '\t' '\r']*
      { let l = (String.length (lexeme lexbuf)) in 
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
		else main lexbuf }	
	
	
and main = parse
  (* Les espaces sont ignorés *)
  | [' ' '\t' '\r']*
      { chars := !chars+(lexeme_end lexbuf)-(lexeme_start lexbuf); main lexbuf }
  | '\n'
      { lines := !lines+1; chars := 1; line_started := false; new_line lexbuf; token lexbuf }
  (* Les chaînes alphabétiques sont traitées par la fonction [id_or_keyword]
     pour être associées à des mots-clés ou des identifiants. *)
  | alpha+
      { line_started := true; chars := !chars+(lexeme_end lexbuf)-(lexeme_start lexbuf); let word = id_or_keyword (lexeme lexbuf) in 
		if word == IF then is_next_if := true; word}
  (* Début et fin de struct/array *)
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
  | ","
	  { chars := !chars+1; COMMA }
  (* Commentaires avec une variable qui indique si le commentaire est multi-lignes ou pas *)
  | "//"
	  { chars := !chars+2; comment false lexbuf }
  | "/*"
	  { chars := !chars+2; comment true lexbuf }
  (* Fin de fichier *)
  | eof
      { match !indent_as_if with
		| [] -> EOF
		| hd::tl -> indent_as_if := (List.tl !indent_as_if); END}
  (* Caractères non reconnus *)
  | _
      { failwith ("Unknown character : " ^ (lexeme lexbuf) ^ " on line " ^ string_of_int(!lines) ^ " at position " ^ string_of_int(!chars)) }

and comment multi = parse
  | '\n'
      { lines := !lines+1; 
	    chars := 1; 
		if multi then comment multi lexbuf 
		else begin line_started := false; main lexbuf end }
  | "*/"
      { chars := !chars+2; if multi then main lexbuf else comment multi lexbuf }
  | eof
      { if multi then failwith ("Reached end of file before comment was closed") else EOF }
  | _
	  { chars := !chars+1; comment multi lexbuf }
