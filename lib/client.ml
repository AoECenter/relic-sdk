open Lwt.Syntax

type t =
  { domain : string
  ; game : Data.Game.t
  ; session : Authentication.Session.t option
  }

let create domain game = { domain; game; session = None }

let get_json (url : Uri.t) =
  let* resp, body = Cohttp_lwt_unix.Client.get url in
  let status = Cohttp.Response.status resp in
  if Cohttp.Code.code_of_status status = 200
  then
    let* body = Cohttp_lwt.Body.to_string body in
    let json = Yojson.Basic.from_string body in
    Lwt.return (Some json)
  else (
    (* TODO: Find out what to do with this later. What's the return type? Do we have Result<a,b>? *)
    let url_str = Uri.to_string url in
    let* _ =
      Lwt_io.printl (Printf.sprintf "HTTP Error: %s for URL: %s" (Cohttp.Code.string_of_status status) url_str)
    in
    Lwt.return None)
;;

let get ?requester endpoint client =
  let actual_requester = match requester with Some r -> r | None -> get_json in
  let* json = endpoint client.game client.domain actual_requester in
  Lwt.return json
;;
