open Bigarray

let decode_base64_exn base64_str =
  let compressed_data = Base64.decode_exn base64_str in
  let compressed_len = String.length compressed_data in
  let compressed_ba = Array1.create char c_layout compressed_len in
  for i = 0 to compressed_len - 1 do
    Array1.set compressed_ba i compressed_data.[i]
  done;
  compressed_ba, compressed_len
;;

let decompress_base64_str ?(buffer_size_factor = 12) base64_str =
  let compressed_ba, compressed_len = decode_base64_exn base64_str in
  let inflate_state = Zlib.create_inflate () in
  inflate_state.in_buf <- compressed_ba;
  inflate_state.in_len <- compressed_len;
  let output_len = compressed_len * buffer_size_factor in
  let output_ba = Array1.create char c_layout output_len in
  inflate_state.out_buf <- output_ba;
  inflate_state.out_len <- output_len;
  let status = Zlib.flate inflate_state Finish in
  match status with
  | Ok | Stream_end ->
    let result_len = output_len - inflate_state.out_len in
    Some (String.init result_len (fun i -> Array1.get output_ba i))
  | Need_dict ->
    Printf.eprintf "Decompression error: Need dictionary\n";
    None
  | Buf_error ->
    Printf.eprintf "Decompression error: Buffer error\n";
    None
  | Data_error msg ->
    Printf.eprintf "Decompression error: Data error (%s)\n" msg;
    None
;;
