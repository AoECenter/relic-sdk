let encode_lst_i lst = "[" ^ String.concat "," (List.map (fun item -> string_of_int item) lst) ^ "]"
let encode_lst_f lst = "[" ^ String.concat "," (List.map (fun item -> string_of_float item) lst) ^ "]"
let encode_lst_s lst = "[" ^ String.concat "," (List.map (fun item -> "\"" ^ item ^ "\"") lst) ^ "]"
