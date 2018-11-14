{

  open Lexing
  open String
  open List
  
  (* Table qui va associer à une macro son nombre d'arguments et le texte *)
  let macros_table = Hashtbl.create 29
  
  let add_macro name args text =
	Hashtbl.add macros_table name (args,text)

  let get_macro name =
    Hashtbl.find macros_table name
  
}

let alpha = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']

(* Règle de départ qui part soit dans la détection d'une macro soit dans le parsing du code *)
rule preprocess = parse
  | "#DEFINE "
    { macro_name lexbuf }
  (* On traite le cas où le code commence directement par une macro *)
  | "#"
	{ code_macro "" lexbuf }
  | eof
	{ "" }
  | _
	{ code (lexeme lexbuf) lexbuf }

(* Si on détecte une macro, on lit son nom *)
and macro_name = parse
  | alpha+
    { macro_args (lexeme lexbuf) lexbuf }
  | _
	{ failwith ("Expected only alphabetic characters for a macro name but got : " ^ (lexeme lexbuf)) }

(* On lit le nombre d'arguments d'une macro *)	
and macro_args name = parse
  | "{" [^'}']+ "} "
    { let nb_args = int_of_string(String.sub (lexeme lexbuf) 1 ((String.length (lexeme lexbuf))-3)) in
		macro_text name nb_args lexbuf }
  | ' '
	{ macro_text name 0 lexbuf }
  | _
	{ failwith ("Expected number of args for the macro or a whitespace but got : " ^ (lexeme lexbuf)) }
	
(* On lit le texte de la macro et on revient au point de départ *)
and macro_text name args = parse
  | [^'\n']+ '\n'
	{ add_macro name args (sub (lexeme lexbuf) 0 ((String.length (lexeme lexbuf))-1)); preprocess lexbuf }
  | _
	{ failwith ("Expected the text corresponding to the macro but got : " ^ (lexeme lexbuf)) }

(* On parse simplement le code jusqu'à détecter une macro *)
and code text = parse
  | "#"
	{ code_macro text lexbuf }
  | [^'#']+ 
	{ code (text^(lexeme lexbuf)) lexbuf }
  | eof
	{ text }
  
(* On lit le nom de la macro, on récupère le nombre d'arguments et le texte *)
and code_macro text = parse
  | alpha+
    { let (nb_args,text_macro) = get_macro (lexeme lexbuf) in
		let (args,lexbuf,next_char) = code_args [] nb_args lexbuf in
			let text_macro = (code_text "" args (from_string text_macro))  in
			code (text^text_macro^(String.make 1 next_char)) lexbuf }
  | _
	{ failwith ("Expected the name of a macro but got : " ^ (lexeme lexbuf)) }

(* On lit la liste des arguments pour la renvoyer à code_macro *)
and code_args list nb_args = parse
  | '{' [^'}']+ '}'
	{ let new_arg = sub (lexeme lexbuf) 1 ((String.length (lexeme lexbuf))-2) in
		code_args (new_arg::list) (nb_args-1) lexbuf }
  | _ as next_char
	{ if nb_args == 0 then (List.rev list,lexbuf, next_char) else failwith "Wrong number of arguments" }
	
(* On lit le texte de la macro en remplaçant les appels aux arguments par les bonnes valeurs *)
and code_text text args = parse
  | '#' digit+
    {let nb = int_of_string(sub (lexeme lexbuf) 1 ((String.length (lexeme lexbuf))-1)) in
		let arg_text = (nth args (nb-1)) in 
		code_text (text^arg_text) args lexbuf }
  |	[^'#']+
	{ code_text (text^(lexeme lexbuf)) args lexbuf }
  | eof
	{ text }
