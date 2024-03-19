open Lwt.Syntax

type client =
  { domain : string
  ; game : Data.Game.game
  }

let create domain game = { domain; game }

let get_json url =
  let* resp, body = Cohttp_lwt_unix.Client.get url in
  let status = Cohttp.Response.status resp in
  if Cohttp.Code.code_of_status status = 200
  then
    let* body = Cohttp_lwt.Body.to_string body in
    let json = Yojson.Basic.from_string body in
    Lwt.return @@ Some json
  else
    (* Find out what to do with this later. What's the return type? Do we have Result<a,b>? *)
    let* _ = Lwt_io.printl (Printf.sprintf "HTTP Error: %s" (Cohttp.Code.string_of_status status)) in
    Lwt.return None
;;

let get ?requester endpoint client =
  let actual_requester = match requester with Some r -> r | None -> get_json in
  let* json = endpoint client.game client.domain actual_requester in
  Lwt.return json
;;
