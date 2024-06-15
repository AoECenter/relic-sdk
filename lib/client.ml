open Lwt.Syntax

type t =
  { domain : string
  ; game : Data.Game.t
  ; cookie : Data.Platform.Cookie.t option
  }

(** A global request counter is required for the API *)
let request_count = ref 0

(** Always use this to access the request count to ensure it increments *)
let count_request () =
  request_count := !request_count + 1;
  !request_count
;;

let create_client_with_steam_credentials (domain : string) (game : Data.Game.t) (login : Data.Platform.Steam_login.t)
  =
  let* cookie = Data.Platform.Cookie.create login domain in
  let* _ =
    match cookie with
    | Some c ->
      Logger.Async.info
        ~m:"Client"
        ~f:"create_client_with_steam_credentials"
        "Created new cookie '%s' from steam credentials"
        (Data.Platform.Cookie.to_cookie_string c)
    | None ->
      Logger.Async.error
        ~m:"Client"
        ~f:"create_client_with_steam_credentials"
        "Unable to create cookie from steam credentials"
  in
  Lwt.return { domain; game; cookie }
;;

let create ?(login = None) ?(cookie = None) domain game =
  match cookie with
  | Some _ ->
    let* _ = Logger.Async.info ~m:"Client" ~f:"create" "Creating client with existing cookie" in
    Lwt.return { domain; game; cookie }
  | None ->
    (match login with
     | Some l ->
       let* _ = Logger.Async.info ~m:"Client" ~f:"create" "Creating client with steam credentials" in
       create_client_with_steam_credentials domain game l
     | None ->
       let* _ = Logger.Async.info ~m:"Client" ~f:"create" "Created unauthenticated client" in
       Lwt.return { domain; game; cookie = None })
;;

let add_cookie_query_to_url (cookie : Data.Platform.Cookie.t option) (url : Uri.t) =
  match cookie with
  | None -> url
  | Some c -> Uri.add_query_params' url [ "sessionID", c.session_id; "connect_id", c.session_id ]
;;

let add_call_num_to_url (url : Uri.t) = Uri.add_query_params' url [ "callNum", string_of_int @@ count_request () ]

let create_headers_from_cookie (cookie : Data.Platform.Cookie.t option) =
  match cookie with
  | None -> Cohttp.Header.init ()
  | Some c -> Cohttp.Header.add (Cohttp.Header.init ()) "Cookie" (Data.Platform.Cookie.to_cookie_string c)
;;

let report_http_error (status : Cohttp.Code.status_code) (url : Uri.t) (body : string) =
  let* _ =
    Logger.Async.error
      ~m:"Client"
      ~f:"report_http_error"
      "HTTP Error: %s for URL: %s. Response: %s"
      (Cohttp.Code.string_of_status status)
      (Uri.to_string url)
      body
  in
  Lwt.return_none
;;

let report_json_body (body_str : string) =
  let json = Yojson.Basic.from_string body_str in
  Lwt.return_some json
;;

let get_json ?(cookie = None) (url : Uri.t) =
  let url = add_call_num_to_url @@ add_cookie_query_to_url cookie url in
  let headers = create_headers_from_cookie cookie in
  let* resp, body = Cohttp_lwt_unix.Client.get ~headers url in
  let status = Cohttp.Response.status resp in
  let status_i = Cohttp.Code.code_of_status status in
  let* _ = Logger.Async.debug ~m:"Client" ~f:"get_json" "GET json from %s result: %d" (Uri.to_string url) status_i in
  let* body_str = Cohttp_lwt.Body.to_string body in
  if status_i = 200 then report_json_body body_str else report_http_error status url body_str
;;

let get ?requester endpoint client =
  let actual_requester = match requester with Some r -> r | None -> get_json ~cookie:client.cookie in
  let* json = endpoint client.game client.domain actual_requester in
  Lwt.return json
;;
