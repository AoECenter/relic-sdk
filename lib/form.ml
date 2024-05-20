open Lwt.Syntax
open Cohttp_lwt

let post (url : Uri.t) (form_data : (string * string) list) =
  let headers = Header.init_with "Content-Type" "application/x-www-form-urlencoded" in
  let body = Uri.encoded_of_query form_data in
  let* resp, body = Client.post ~headers ~body:(Body.of_string body) url in
  let status = Response.status resp in
  if Code.code_of_status status = 200
  then
    let* body = Body.to_string body in
    let json = Yojson.Basic.from_string body in
    Lwt.return (Some json)
  else (
    let url_str = Uri.to_string url in
    let* _ = Lwt_io.printl (Printf.sprintf "HTTP Error: %s for URL: %s" (Code.string_of_status status) url_str) in
    Lwt.return None)
;;
