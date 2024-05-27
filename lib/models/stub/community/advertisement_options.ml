type t = string list

let from_zlib_b64_str compressed_input =
  match Compression.Domain.decompress_base64_str compressed_input with
  | None ->
    Printf.printf "Decompression failed: Input may be corrupted or invalid.\n";
    None
  | Some input ->
    (try
       let no_quotes = String.concat "" (String.split_on_char '"' input) in
       match Base64.decode no_quotes with
       | Ok decoded_data -> Some (String.split_on_char ':' decoded_data)
       | Error _ ->
         Printf.printf "Base64 decoding failed: Data may be corrupted or improperly encoded.\n";
         None
     with
     | ex ->
       Printf.printf "Unexpected error: %s\n" (Printexc.to_string ex);
       None)
;;
