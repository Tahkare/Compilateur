%{

  (* Contexte *)
  open Lexing
  open CommonAST
  open SourceLocalisedAST
  
  let counter = ref 0
  
  type assign =   Expr of localised_expression
				| Array of typ * localised_expression list
				| InitArray of assign list
				| InitStruct of (string * ((string * assign) list))
				| Struct of string
				
  let union_pointer = ref Symb_Tbl.empty
  let struct_pointer = ref Symb_Tbl.empty
  let anonf_pointer = ref Symb_Tbl.empty
  
%}

%token <int> CONST_INT
%token <bool> CONST_BOOL
%token <string> IDENT
%token PLUS MINUS STAR DIV MOD
%token EQUAL NEQ LE LT GE GT
%token SET_INIT
%token AND OR NOT
%token LP RP
%token LC RC

%token VAR
%token INTEGER BOOLEAN

%token MAIN
%token IF ELSE WHILE FOR ELIF
%token BREAK CONTINUE
%token SEMI COMMA DOT COLON
%token SET
%token BEGIN END
%token NEW
%token EOF
%token STRUCT IMMUTABLE
%token UNION SWITCH CASE
%token DEFAULT
%token RETURN
%token FUN ARROW

%left OR
%left AND
%left SET_INIT
%left EQUAL NEQ
%left LE LT GE GT
%left PLUS MINUS
%left STAR DIV MOD
%right NOT
%left SEMI
%left DOT
%nonassoc NEW
%nonassoc LC

%start prog
%type <SourceLocalisedAST.program> prog

%%


/** ------------------
	REGLES PRINCIPALES
	------------------ **/

/* prog va se composer de la déclaration des variables, du code principal et de EOF */
prog:
| vars=decls; functions=fun_decls; main=main; EOF 
	{ (* Cette fonction sert à ajouter toutes les initialisations de variables en début de code. On en fait des localised_instructions et on crée des séquences *)
		let rec make_seq init main =
			(match init with
			[] -> main
			| (id,e)::tl -> let instr = Set(Identifier(Id(id)),e) in
						let l = $startpos.pos_lnum in
						let c = $startpos.pos_cnum - $startpos.pos_bol in
						let instr = mk_instr instr Symb_Tbl.empty l c in
						let instr = Sequence(instr,main) in
						let instr = mk_instr instr Symb_Tbl.empty l c in
						make_seq tl instr)
		in
	    match main with instr,loc_vars -> match vars with glo_vars,inits -> let main = make_seq inits instr in
	    let functions = Symb_Tbl.fold (fun key value tbl -> Symb_Tbl.add key value tbl) !anonf_pointer functions in
		{ globals = Symb_Tbl.add "arg" TypInt glo_vars; structs = !struct_pointer; union = !union_pointer; functions = Symb_Tbl.add "main_int" {signature={return=TypInt;formals=["arg",TypInt]};code=main;locals=loc_vars;} functions } }
;

decls:
| v=var_decls { v }	
| struct_decls; vars=decls { vars }
| v=var_decls; vars=decls { match v with vlist,ilist -> match vars with vars_declared,init_declared -> (Symb_Tbl.fold(fun key value tbl -> Symb_Tbl.add key value tbl) vlist vars_declared,(ilist@init_declared)) }

/** --------------------------
	DECLARATION DES STRUCTURES
	-------------------------- **/
	
struct_decls:
| STRUCT; i=IDENT; begin_; f=field_decl; end_ { struct_pointer := Symb_Tbl.add i (i,{fields=f}) !struct_pointer }
| STRUCT; i=IDENT; UNION; begin_ ; u=union_decl; end_  { let a = List.fold_left (fun l x -> match x with (tag,_) -> tag::l) [] u in union_pointer := Symb_Tbl.add i a !union_pointer;
																		 List.fold_left (fun a x -> match x with (tag,f) -> struct_pointer := Symb_Tbl.add tag (i,{fields=f}) !struct_pointer) () u }
;

union_decl:
| i=IDENT; begin_ ; f=field_decl; end_ ; SEMI { [(i,f)] }
| i=IDENT; begin_ ; f=field_decl; end_ ; SEMI; u=union_decl { (i,f)::u }
;

field_decl:
| t=type_all; i=IDENT; SEMI { [(i,t,false)] }
| t=type_all; i=IDENT; SEMI; f=field_decl { (i,t,false)::f }
| IMMUTABLE; t=type_all; i=IDENT; SEMI { [(i,t,true)] }
| IMMUTABLE; t=type_all; i=IDENT; SEMI; f=field_decl { (i,t,true)::f }
; 
	
/** -------------------------
	DECLARATION DES VARIABLES
	------------------------- **/
		
/* Séquence de déclaration de variables 
   On va remplir une table avec le types des variables et renvoyer une liste avec les variables à initialiser et les valeurs associées */
var_decls:
| /*empty*/ { (Symb_Tbl.empty,[]) }
| VAR; t=type_; i=ident_init_list; SEMI; v=var_decls { match i with vars,init -> match v with vlist,inits ->
			let inits = (init@inits) in
			let vars = List.fold_left (fun tbl x -> Symb_Tbl.add x t tbl) vlist vars in
			(vars,inits) }
| VAR; t=type_array; i=ident_list; SEMI; v=var_decls { match v with vlist,inits -> 
													   let vars = List.fold_left (fun tbl x -> Symb_Tbl.add x t tbl) vlist i in 
													   (vars,inits) }
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : variables not declared correctly" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;

/* Séquence d'identifiants */
/* La première liste renvoie les identifiants et la deuxième renvoie les identifiants et leurs expressions associées pour ceux qui en ont une. 
Elle est utilisée dans les initialisations en début de programme */
ident_init_list:
| i=IDENT { ([i],[]) }
| i=IDENT; COMMA; l=ident_init_list  { match l with vars,init -> ((i::vars),init) }
| i=IDENT; SET_INIT; e=localised_expression { ([i],[(i,e)]) }
| i=IDENT; SET_INIT; e=localised_expression; comma; l=ident_init_list
	{ match l with
		vars,init -> ((i::vars),((i,e)::init)) }
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : identifier and assignemnt list not properly formed" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;

ident_list:
| i=IDENT { [i] }
| i=IDENT; COMMA; l=ident_list { i::l }
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : identifier list not properly formed" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;

/** -------------------------
	DECLARATION DES FONCTIONS
	------------------------- **/
	
fun_decls:
| /*empty*/ { Symb_Tbl.empty }
| t=type_all; i=IDENT; lp; p=parameters; rp; b=block; f=fun_decls {  let name = (List.fold_left (fun str (x,t) -> let rec tts = function
																													| TypInt -> "int"
																													| TypBool -> "bool"
																													| TypArray t -> "array_of_"^(tts t)
																													| TypStruct s -> "struct_"^s
																													| TypVoid -> "void"
																													| TypAny -> "any" 
																													in (str^("_"^(tts t))) ) i p) in
																	 match b with j,v -> let g = {signature = { return = t; formals = p; }; code = j; locals = v; } in Symb_Tbl.add name g f } 
| i=IDENT; lp; p=parameters; rp; b=block; f=fun_decls { let name = (List.fold_left (fun str (x,t) -> let rec tts = function
																													| TypInt -> "int"
																													| TypBool -> "bool"
																													| TypArray t -> "array_of_"^(tts t)
																													| TypStruct s -> "struct_"^s
																													| TypVoid -> "void"
																													| TypAny -> "any" 
																													in (str^("_"^(tts t))) ) i p) in
														 match b with j,v -> let g = {signature = { return = TypVoid; formals = p; }; code = j; locals = v; } in  Symb_Tbl.add name g f }
;

parameters:
| /*empty*/ { [] }
| p=params_aux { p }
;

params_aux:
| t=type_all; i=IDENT { [(i,t)] }
| t=type_all; i=IDENT; comma; p=params_aux { (i,t)::p }
;

/** -------------------
	PARTIE INSTRUCTIONS
	------------------- **/

/* Bloc de code principal, formé du mot-clé [main] suivi par le bloc proprement dit. */
main:
| MAIN; i=block { i }
;

/* Un bloc est une instruction ou séquence d'instructions entre accolades. */
block:
| begin_; v=var_decls; i=localised_instruction; end_ { let rec make_seq init loc_instr =
														(match init with
														[] -> loc_instr
														| (id,e)::tl -> let instr = Set(Identifier(Id(id)),e) in
																	let l = $startpos.pos_lnum in
																	let c = $startpos.pos_cnum - $startpos.pos_bol in
																	let instr = mk_instr instr Symb_Tbl.empty l c in
																	let instr = Sequence(instr,loc_instr) in
																	let instr = mk_instr instr Symb_Tbl.empty l c in
																	make_seq tl instr)
														in match v with vars,inits -> (make_seq inits i,vars)
													 }
;

/* Instruction localisée : on mémorise les numéros de ligne et de colonne du début de l'instruction.
   Voir dans la doc la définition de [Lexing.position] pour la signification de [pos_lnum], [pos_cnum] et [pos_bol]. */
localised_instruction:
| i=instruction { match i with i,v ->
				  let l = $startpos.pos_lnum in
                  let c = $startpos.pos_cnum - $startpos.pos_bol in
                  mk_instr i v l c }
;


/* Instructions */
instruction:
/* Si pas d'instruction, on renvoie l'instruction neutre. */
| /* empty */  { (Nop,Symb_Tbl.empty) }
| l=location; a=assign_expr; ass=assignment
	/* Assigne une liste de valeurs à une liste de variables. On va d'abord assigner toutes les valeurs à des variables temporaires puis assigner les variables temporaires aux variables finales. Cela évite d'avoir une variable modifiée avant d'etre assignée */
	{   let tmp_vars = ref Symb_Tbl.empty in
		(* Fonctions génériques *)
		let make_instr i =
			let l = $startpos.pos_lnum in
			let c = $startpos.pos_cnum - $startpos.pos_bol in
			mk_instr i Symb_Tbl.empty l c
        
        in let make_expr e =
			let l = $startpos.pos_lnum in
			let c = $startpos.pos_cnum - $startpos.pos_bol in  
			mk_expr e l c	
		
		(* Fonction qui appelle la bonne fonction de création en fonction de l'assignment en argument *)
		in let rec make_assignment l ass init = 
			match ass with
			| Expr(e) -> if init then InitSet(l,e) else Set(l,e)
			| Array(t,a) -> make_array l t a init
			| InitArray(_) -> make_array_init l ass init
			| InitStruct(_) -> make_struct_init l ass init
			| Struct(i) -> make_struct l i init
		
		(* Fonction pour la création d'une structure non initialisée *)
		and make_struct l i init =
			if init then InitSet(l, make_expr(NewRecord(i))) else Set(l, make_expr(NewRecord(i)))
		
		
		(* Fonctions pour la création d'une structure initialisée *)
		and make_rec_struct l fl init =
			match fl with
			| (s,a)::[] -> let m = (FieldAccess(make_expr (Location(l)),s)) in make_assignment m a true
			| (s,a)::tl -> let m = (FieldAccess(make_expr (Location(l)),s)) in Sequence(make_instr (make_assignment m a true),make_instr (make_rec_struct l tl init))
			| _ -> failwith "Expected a struct with fields"
		and make_struct_init l struct_ init =
			match struct_ with
			| InitStruct(s,fl) -> counter := !counter + 1; 
								  let tmp = ("_tmp"^(string_of_int !counter)) in 
								  tmp_vars := Symb_Tbl.add tmp TypAny !tmp_vars;
								  let (i,_) = Symb_Tbl.find s !struct_pointer in
								  let set_instr = if init then InitSet(l, make_expr(NewRecord(s))) else Set(l, make_expr(NewRecord(s))) in
								  if i=s then Sequence(make_instr (set_instr),make_instr (make_rec_struct l fl true))
										 else Sequence(make_instr (set_instr), make_instr( Switch(tmp,l,[(s,make_instr (make_rec_struct l fl true));("default",make_instr Nop)])))
			| _ -> failwith "Expected an initialized struct"
		
		
		(* Fonctions pour la création d'un tableau non initialisé *)	
		and get_array_type t a =
			match a with
			| hd::[] -> t
			| hd::tl -> TypArray(get_array_type t tl)
			| _ -> failwith "Cannot create a 0-dimensional array"
		and make_array l t a init =
			match a with
			| hd::[] -> if init then InitSet(l,make_expr (NewArray(hd,t))) else Set(l,make_expr (NewArray(hd,t)))
			| hd::tl -> counter := !counter+1;
						let tmp = "_tmp"^(string_of_int !counter) in
						tmp_vars := Symb_Tbl.add tmp TypAny !tmp_vars;
						let set_instr = if init then InitSet(l,make_expr (NewArray(hd,get_array_type t a))) else Set(l,make_expr (NewArray(hd,get_array_type t a))) in
						Sequence(make_instr (set_instr),
						make_instr(For(
							make_instr(Set(Identifier(Id(tmp)),make_expr(Literal(Int(0))))), 
							make_expr(BinaryOp(Lt, make_expr (Location(Identifier(Id(tmp)))),hd)), 
							make_instr(Set(Identifier(Id(tmp)), make_expr (BinaryOp(Add, make_expr(Literal(Int(1))),make_expr (Location(Identifier(Id(tmp)))))))),  
							make_instr (make_array (ArrayAccess(make_expr (Location(l)),make_expr(Location(Identifier(Id(tmp)))))) t tl init)
							)))
			| _ -> failwith "Cannot create a 0-dimensional array"
		
		
		(* Fonctions pour la création d'un tableau initialisé *)
		and get_sub_type array =
			match array with
			| InitArray(l) -> List.fold_left (fun t x -> if t = None then begin
																	 match x with
																	 | InitStruct(s,m) -> Some (TypStruct(s))
																	 | InitArray(a) -> (match (get_sub_type x) with
																					   | Some(u) -> Some(TypArray(u))
																					   | None -> None)
																	 | Struct(i) -> let (s,w) = Symb_Tbl.find i !struct_pointer in (Some(TypStruct(s)))
																	 | Array(at,a) -> (match List.fold_left (fun t2 x2 -> TypArray(t2)) at a with
																					   |TypArray(u) -> Some u
																					   | _ -> failwith "Expected an array type")
																	 | Expr(e) -> (match e.expr with
																				   | Literal(Int(_)) -> Some TypInt
																				   | Literal(Bool(_)) -> Some TypBool
																				   | UnaryOp(o,_) -> (match o with
																									  | Minus -> Some TypInt
																									  | Not -> Some TypBool)
																				   | BinaryOp(o,_,_) -> (match o with
																										 | Add | Sub | Mult | Div | Mod -> Some TypInt
																										 | _ -> Some TypBool)
																				   | Location(l) -> failwith "Not inferred yet"
																				   | _ -> failwith "Not inferred yet")
																	 end else t) None l
			| _ -> failwith "Expected an initialized array"
		
		and make_rec_array l n a init =
			let m = ArrayAccess(make_expr (Location(l)), make_expr (Literal(Int(n)))) in
			match a with
			| hd::[] -> make_assignment m hd init
			| hd::tl -> Sequence(make_instr(make_assignment m hd init), make_instr(make_rec_array l (n+1) tl init))
			| _ -> failwith "Expected a non-empty array"
		and make_array_init l array init =
			let t = get_sub_type array
			in let t = (match t with
						| Some u -> u
						| None -> failwith "Could not assert the type of initialized array")
			in match array with
			| InitArray(a) -> let set_instr = if init then InitSet(l, make_expr(NewArray(make_expr(Literal(Int(List.length a))), t))) else Set(l, make_expr(NewArray(make_expr(Literal(Int(List.length a))), t))) in
							  Sequence(make_instr (set_instr), make_instr(make_rec_array l 0 a true))
			| _ -> failwith "Expected an initialized array"
		
		
		(* iter génère la liste d'association aux vars temporaires puis aux vars permanentes *)
	    in let rec iter s e instr = 
			match s,e,instr with
			| [],[],(i1,i2) -> (i1,i2)
			| (id::tl),(e::etl),(i1,i2) -> 
					counter := !counter+1;
					let tmp = "_tmp"^(string_of_int !counter) in
					tmp_vars := Symb_Tbl.add tmp TypAny !tmp_vars;
					iter tl etl (make_instr (Sequence(i1, make_instr (make_assignment (Identifier(Id(tmp))) e false))),make_instr (Sequence(i2,make_instr (Set(id,make_expr (Location(Identifier(Id(tmp)))))))))
			| _ , _, _ -> let pos = $startpos in failwith (Printf.sprintf "Syntax error at %d, %d : not the same number of arguments on each side of the assignment" pos.pos_lnum (pos.pos_cnum - pos.pos_bol))

	    in match a with s,e -> (match s with
				| [] -> let a = make_assignment l ass false in (a,!tmp_vars)
				| hd::tl -> match (iter (l::s) (e@[ass]) (make_instr Nop,make_instr Nop)) with m,g -> (Sequence(m,g),!tmp_vars))
	   }
	   
| IF; lp; c=localised_expression; rp; t=block; ELSE; e=block { match t with (t,v1) -> match e with (e,v2) -> 
	  let vars = (Symb_Tbl.fold (fun key value tbl -> Symb_Tbl.add key value tbl) v1 v2) in
	  (Conditional(c,t,e),vars) }
| IF; lp; cond=localised_expression; rp; t=block
	/* Dans le cas où il n'y a aucun else, on génère une instruction_localisée nop à la place */
	{ let l = $startpos.pos_lnum in
	  let c = $startpos.pos_cnum - $startpos.pos_bol in
	  let nop = (mk_instr Nop Symb_Tbl.empty l c) in
	  match t with t,v ->
	  (Conditional(cond,t,nop),v) }
| IF; lp; cond=localised_expression; rp; b=block; e=cascade_else
	/* Dans le cas où on a une cascade de if/elif/else, on va appeler une règle qui génère une liste de elif/else et localiser cette instruction pour créer l'instruction conditionnelle */
	{ match e with e,f ->
	  let l = $startpos.pos_lnum in
	  let c = $startpos.pos_cnum - $startpos.pos_bol in
	  let e = (mk_instr e f l c) in
	  match b with b,v ->
	  (Conditional(cond,b,e),v) }
| WHILE; lp; c=localised_expression; rp; b=block { match b with b,v -> Loop(c,b),v }
| FOR; lp; init=localised_instruction; comma; cond=localised_expression; comma; 
	incr=localised_instruction; rp; b=block { match b with b,v -> For(init,cond,incr,b),v }
| BREAK { Break,Symb_Tbl.empty }
| CONTINUE { Continue,Symb_Tbl.empty }
| SWITCH; lp; l=location; rp; begin_; c=case_list; end_ { counter := !counter + 1; let s = "_tmp"^(string_of_int !counter) in (Switch(s,l,c),Symb_Tbl.singleton s TypAny) }
| RETURN; lp; e=localised_expression; rp { Return(e),Symb_Tbl.empty }
| BEGIN; v=var_decls; i=localised_instruction; end_ { 	let l = $startpos.pos_lnum in
														let c = $startpos.pos_cnum - $startpos.pos_bol in
														let n = mk_instr Nop Symb_Tbl.empty l c in
														let rec make_seq init loc_instr =
															(match init with
															[] -> loc_instr
															| (id,e)::tl -> let instr = Set(Identifier(Id(id)),e) in
																		let instr = mk_instr instr Symb_Tbl.empty l c in
																		let instr = Sequence(instr,loc_instr) in
																		let instr = mk_instr instr Symb_Tbl.empty l c in
																		make_seq tl instr)
														in match v with vars,init -> (Sequence((make_seq init i),n),vars) }
| i=IDENT; LP; a=arguments; rp { ProcCall(Id(i),a),Symb_Tbl.empty }
| i1=localised_instruction; SEMI; i2=localised_instruction { Sequence(i1,i2),Symb_Tbl.empty }
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : instruction not properly formed" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;

assign_expr:
| SET { ([],[]) }
| COMMA; l=location;  a=assign_expr; ass=assignment; COMMA { match a with llist,elist -> (l::llist,elist@[ass]) }
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : assignment not properly formed" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;

/* Règle pour gérer les else en cascade */
cascade_else:
| ELIF; lp; cond=localised_expression; rp; b=block; e=cascade_else
	{ match e with e,f -> let l = $startpos.pos_lnum in
	  let c = $startpos.pos_cnum - $startpos.pos_bol in
	  let e = (mk_instr e f l c) in
	  match b with b,v ->
	  (Conditional(cond,b,e),v) }
| ELIF; lp; cond=localised_expression; rp; t=block; else_; e=block 
	{ match t with (t,v1) -> match e with (e,v2) -> 
	  let vars = (Symb_Tbl.fold (fun key value tbl -> Symb_Tbl.add key value tbl) v1 v2) in
	  Conditional(cond,t,e),vars }	
;

case_list:
| CASE; i=IDENT; COLON; l=localised_instruction; SEMI { [(i,l)] }
| CASE; DEFAULT; COLON; l=localised_instruction; SEMI { [("default",l)] }
| CASE; i=IDENT; COLON; l=localised_instruction; SEMI; c=case_list { (i,l)::c }
;


/** ------------------
    PARTIE EXPRESSIONS
	------------------ **/
	
/* Expression localisée : on mémorise les numéros de ligne et de colonne du
   début de l'expression.
   Voir dans la doc la définition de [Lexing.position] pour la signification
   de [pos_lnum], [pos_cnum] et [pos_bol]. */
localised_expression:
| e=expression { let l = $startpos.pos_lnum in
                  let c = $startpos.pos_cnum - $startpos.pos_bol in
                  mk_expr e l c }
;

/* Expression */
expression:
| e=CONST_INT { Literal(Int(e)) }
| e=CONST_BOOL { Literal(Bool(e)) }
| e=location { Location(e) }
| LP; e=expression; rp { e }
| e1=localised_expression; PLUS; e2=localised_expression { BinaryOp(Add,e1,e2) }
| e1=localised_expression; MINUS; e2=localised_expression { BinaryOp(Sub,e1,e2) }
| e1=localised_expression; STAR; e2=localised_expression { BinaryOp(Mult,e1,e2) }
| e1=localised_expression; DIV; e2=localised_expression { BinaryOp(Div,e1,e2) }
| e1=localised_expression; MOD; e2=localised_expression { BinaryOp(Mod,e1,e2) }
| e1=localised_expression; EQUAL; e2=localised_expression { BinaryOp(Eq,e1,e2) }
| e1=localised_expression; NEQ; e2=localised_expression { BinaryOp(Neq,e1,e2) }
| e1=localised_expression; LE; e2=localised_expression { BinaryOp(Le,e1,e2) }
| e1=localised_expression; LT; e2=localised_expression { BinaryOp(Lt,e1,e2) }
| e1=localised_expression; GT; e2=localised_expression { BinaryOp(Gt,e1,e2) }
| e1=localised_expression; GE; e2=localised_expression { BinaryOp(Ge,e1,e2) }
| e1=localised_expression; AND; e2=localised_expression { BinaryOp(And,e1,e2) }
| e1=localised_expression; OR; e2=localised_expression { BinaryOp(Or,e1,e2) }
| e1=localised_expression; SET_INIT; e2=localised_expression { BinaryOp(LEq,e1,e2) }
| MINUS; e1=localised_expression { UnaryOp(Minus,e1) }
| NOT; e1=localised_expression { UnaryOp(Not,e1) }
| LP; FUN; t=type_all; LP; p=parameters; RP; ARROW; i=localised_instruction; RP; LP; a=arguments; RP { counter := !counter+1;
																									   let name = ("_anon"^(string_of_int !counter)) in
																									   anonf_pointer := Symb_Tbl.add name {signature={return=t; formals=p}; code=i; locals=Symb_Tbl.empty} !anonf_pointer;
																									   FunCall(Id(name),a) }
| i=IDENT; LP; a=arguments; rp { FunCall(Id(i),a) }
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : expression not properly formed" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;

location:
| i=IDENT { Identifier(Id(i)) }
| e=localised_expression; DOT; i=IDENT { FieldAccess(e,i) }
| lo=location; LC; e=localised_expression; rc 
	{ let l = $startpos.pos_lnum in
	  let c = $startpos.pos_cnum - $startpos.pos_bol in
	  let s = (mk_expr (Location(lo)) l c) in
	  ArrayAccess(s,e) }
;

arguments:
| /*empty */ { [] }
| a=args_aux { a }
;

args_aux:
| e=localised_expression { [e] }
| e=localised_expression; comma; a=args_aux { e::a }
;

assignment:
| le=localised_expression { Expr(le) }
| ad=array_decl { ad }
| aid=array_init_decl { aid }
| sid=struct_init_decl { sid }
| sd=struct_decl { sd }
;

array_decl:
| NEW; t=type_ ; a=array { Array(t,a) }
; 

array:
| LC; e=localised_expression; rc { [e] }
| LC; e=localised_expression; rc; a=array { e::a }
; 

array_init_decl:
| NEW; BEGIN; a=assignment_list; END { InitArray(a) }
;

assignment_list:
| a=assignment { [a] }
| a=assignment; SEMI; al=assignment_list { a::al }
;

struct_decl:
| NEW; i=IDENT { Struct(i) }
;

struct_init_decl:
| NEW; i=IDENT; BEGIN; f=field_init_decl; END { InitStruct(i,f) }
;

field_init_decl:
| i=IDENT; SET; a=assignment; SEMI { [(i,a)] }
| i=IDENT; SET; a=assignment; SEMI; f=field_init_decl { (i,a)::f }
;


/** ------------
	PARTIE TYPES
	------------ **/

type_all:	
| t=type_ { t }
| t=type_array { t }
	
type_ :
| INTEGER { TypInt }
| BOOLEAN { TypBool }
| i=IDENT { TypStruct(i) }
;

type_array:
| t=type_; LC; rc { TypArray(t) }
| t=type_array; LC; rc { TypArray(t) }
;

/** ---------------
	PARTIE KEYWORDS
	--------------- **/

begin_:
| BEGIN {}
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : expected left brace" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;

end_:
| END {}
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : expected right brace" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;

else_:
| ELSE {}
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : expected 'else' keyword" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;

lp:
| LP {}
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : expected left parenthesis" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;

rp:
| RP {}
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : expected right parenthesis" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;

comma:
| COMMA {}
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : expected a comma" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;

rc:
| RC {}
| error { let pos = $startpos in
          let message = Printf.sprintf "Syntax error at %d, %d : expected a right square bracket" pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in failwith message }
;
