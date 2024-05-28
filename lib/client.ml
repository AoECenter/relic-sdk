open Lwt.Syntax

type t =
  { domain : string
  ; game : Data.Game.t
  ; cookie : Data.Platform.Cookie.t option
  }

let create ?(login = None) domain game =
  match login with
  | Some l ->
    let* cookie = Data.Platform.Cookie.create l domain in
    Lwt.return { domain; game; cookie }
  | None -> Lwt.return { domain; game; cookie = None }
;;

let get_json ?(cookie = None) (url : Uri.t) =
  let open Data.Platform.Cookie in
  let url_with_params =
    match cookie with
    | None -> url
    | Some c -> Uri.add_query_params' url [ "sessionID", c.session_id; "connect_id", c.session_id ]
  in
  let headers =
    match cookie with
    | None -> Cohttp.Header.init ()
    | Some c ->
      let cookies_string =
        Printf.sprintf
          "ApplicationGatewayAffinity=%s; ApplicationGatewayAffinityCORS=%s; reliclink=%s"
          c.application_gateway_affinity
          c.application_gateway_affinity_cors
          c.reliclink
      in
      Cohttp.Header.add (Cohttp.Header.init ()) "Cookie" cookies_string
  in
  let* resp, body = Cohttp_lwt_unix.Client.get ~headers url_with_params in
  let status = Cohttp.Response.status resp in
  if Cohttp.Code.code_of_status status = 200
  then
    let* body_str = Cohttp_lwt.Body.to_string body in
    let json = Yojson.Basic.from_string body_str in
    Lwt.return (Some json)
  else (
    (* TODO: Find out what to do with this later. What's the return type? Do we have Result<a,b>? *)
    let url_str = Uri.to_string url_with_params in
    let* _ =
      Lwt_io.printl @@ Printf.sprintf "HTTP Error: %s for URL: %s" (Cohttp.Code.string_of_status status) url_str
    in
    Lwt.return None)
;;

let get ?requester endpoint client =
  let actual_requester = match requester with Some r -> r | None -> get_json ~cookie:client.cookie in
  let* json = endpoint client.game client.domain actual_requester in
  Lwt.return json
;;
