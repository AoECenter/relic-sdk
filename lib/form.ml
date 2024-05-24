open Lwt.Syntax
open Cohttp_lwt_unix

let post (url : Uri.t) (form_data : (string * string) list) =
  let headers = Cohttp.Header.init_with "Content-Type" "application/x-www-form-urlencoded" in
  let body = Uri.encoded_of_query (List.map (fun (k, v) -> k, [ v ]) form_data) in
  let* resp, body = Client.post ~headers ~body:(Cohttp_lwt.Body.of_string body) url in
  let status = Cohttp.Response.status resp in
  if Cohttp.Code.code_of_status status = 200
  then
    let* body = Cohttp_lwt.Body.to_string body in
    let json = Yojson.Basic.from_string body in
    Lwt.return (Some json)
  else (
    let url_str = Uri.to_string url in
    let* _ =
      Lwt_io.printl (Printf.sprintf "HTTP Error: %s for URL: %s" (Cohttp.Code.string_of_status status) url_str)
    in
    Lwt.return None)
;;
