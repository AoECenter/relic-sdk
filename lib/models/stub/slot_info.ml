type t =
  { id : int
  ; slots : Slot.t list
  }

let from_zlib_b64_str compressed_input =
  let open Yojson.Basic.Util in
  match Compression.Domain.decompress_base64_str compressed_input with
  | None -> None
  | Some input ->
    (try
       match Str.split (Str.regexp ",") input with
       | id_str :: json_array_str :: _ ->
         let id = int_of_string id_str in
         let json_list = Yojson.Basic.from_string json_array_str |> to_list in
         Some { id; slots = List.map Slot.from_json json_list }
       | _ -> None
     with
     | _ -> None)
;;
