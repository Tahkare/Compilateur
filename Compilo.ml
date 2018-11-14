open Format

let usage = "usage: ./compilo [options] file.cid"

let data =
    let file = ref None in
	(* Charge le fichier si aucune option n'est spécifiée *)
    let set_file s =
      if not (Filename.check_suffix s ".cid") then
        raise (Arg.Bad "no .cid extension");
      file := Some s
    in
	(* Charge le fichier préprocessé si -pp est spécifiée *)
	let preprocess s =
	  let c = open_in s in
	  let text = (Preprocessor.preprocess (Lexing.from_channel c)) in
      let output_file = (Filename.chop_suffix s ".cid") ^ ".pp.cid" in
      let out = open_out output_file in
      let outf = formatter_of_out_channel out in
      fprintf outf "%s" text;
      close_out out;
      close_in c;
	  file := Some output_file
	in
    Arg.parse [ ("-pp",Arg.String(preprocess),"Runs a preprocessing on the file to expand macros") ] set_file usage;
    match !file with Some f -> f | None -> Arg.usage [] usage; exit 1
	
let () =
  let file = data in
  let c = open_in file in
  let lb = Lexing.from_channel c in
  let prog = SourceParser.prog SourceLexer.token lb in
  close_in c;
  let prog = SourceToTyped.type_program prog in
  let prog = TypedToImp.translate_program prog in
  let prog = ImpToGoto.translate_program prog in 
  let prog = GotoToFlat.translate_program prog in
  let asm = FlatToMips.translate_program prog in
  let output_file = (Filename.chop_suffix file ".cid") ^ ".asm" in
  let out = open_out output_file in
  let outf = formatter_of_out_channel out in
  Mips.print_program outf asm;
  pp_print_flush outf ();
  close_out out;
  exit 0
