let encode_lst_i lst =
  let json_string = "[" ^ String.concat "," (List.map (fun item -> string_of_int item) lst) ^ "]" in
  Uri.pct_encode json_string
;;

let encode_lst_f lst =
  let json_string = "[" ^ String.concat "," (List.map (fun item -> string_of_float item) lst) ^ "]" in
  Uri.pct_encode json_string
;;

let encode_lst_s lst =
  let json_string = "[" ^ String.concat "," (List.map (fun item -> "\"" ^ item ^ "\"") lst) ^ "]" in
  Uri.pct_encode json_string
;;
