let decompress_base64_str ?(buffer_size_factor = 12) base64_str =
  let compressed_data = Base64.decode_exn base64_str in
  let compressed_len = String.length compressed_data in
  let compressed_ba = Bigarray.Array1.create Bigarray.char Bigarray.c_layout compressed_len in
  for i = 0 to compressed_len - 1 do
    Bigarray.Array1.set compressed_ba i compressed_data.[i]
  done;
  let inflate_state = Zlib.create_inflate () in
  inflate_state.Zlib.in_buf <- compressed_ba;
  inflate_state.Zlib.in_len <- compressed_len;
  let output_len = compressed_len * buffer_size_factor in
  let output_ba = Bigarray.Array1.create Bigarray.char Bigarray.c_layout output_len in
  inflate_state.Zlib.out_buf <- output_ba;
  inflate_state.Zlib.out_len <- output_len;
  let status = Zlib.flate inflate_state Zlib.Finish in
  match status with
  | Zlib.Ok | Zlib.Stream_end ->
    let result_len = output_len - inflate_state.Zlib.out_len in
    let result = String.init result_len (fun i -> Bigarray.Array1.get output_ba i) in
    Some result
  | Zlib.Need_dict ->
    Printf.eprintf "Decompression error: Need dictionary\n";
    None
  | Zlib.Buf_error ->
    Printf.eprintf "Decompression error: Buffer error\n";
    None
  | Zlib.Data_error msg ->
    Printf.eprintf "Decompression error: Data error (%s)\n" msg;
    None
;;
