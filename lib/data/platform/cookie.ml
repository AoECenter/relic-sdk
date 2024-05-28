open Lwt.Syntax
open Steam_login

type t =
  { application_gateway_affinity : string
  ; application_gateway_affinity_cors : string
  ; reliclink : string
  ; session_id : string
  ; expires_on : int
  }

let get_seconds_until_expires c = c.expires_on - int_of_float (Unix.time ())

let make_form_data alias auth =
  [ "accountType", [ "STEAM" ]
  ; "activeMatchId", [ "-1" ]
  ; "alias", [ alias ]
  ; "appID", [ "813780" ]
  ; "auth", [ auth ]
  ; "callNum", [ "0" ]
  ; "clientLibVersion", [ "185" ]
  ; "connect_id", [ "" ]
  ; "country", [ "DK" ]
  ; "installationType", [ "windows" ]
  ; "language", [ "en" ]
  ; "macAddress", [ "2C-4D-54-52-2F-2B" ]
  ; "majorVersion", [ "4.0.0" ]
  ; "minorVersion", [ "0" ]
  ; "platformEnvironment", [ "" ]
  ; "platformUserID", [ "" ]
  ; "startGameToken", [ "" ]
  ; "storeLicenseToken", [ "" ]
  ; "storetoken", [ "" ]
  ; "syncHash", [ "[0,0]" ]
  ; "timeoutOverride", [ "0" ]
  ; "title", [ "age2" ]
  ]
;;

let send_form ~headers uri form =
  let body = Uri.encoded_of_query form in
  Cohttp_lwt_unix.Client.post ~headers ~body:(Cohttp_lwt.Body.of_string body) uri
;;

let extract_cookies headers =
  let cookies = Cohttp.Header.get_multi headers "set-cookie" in
  let parse_cookie cookie =
    let parts = String.split_on_char ';' cookie in
    List.hd parts |> String.trim
  in
  List.map parse_cookie cookies
;;

let get_cookie_value cookies name =
  let prefix = name ^ "=" in
  try
    List.find (fun cookie -> String.starts_with ~prefix cookie) cookies
    |> String.split_on_char '='
    |> List.tl
    |> String.concat "="
  with
  | Not_found -> failwith @@ Printf.sprintf "Cookie '%s' not found in '%s'" name (String.concat ";" cookies)
;;

let extract_session_id body_str =
  let json = Yojson.Basic.from_string body_str in
  match Yojson.Basic.Util.to_list json with
  | _ :: second :: _ -> Yojson.Basic.Util.to_string second
  | _ -> failwith "Invalid JSON structure"
;;

let create login domain =
  let form = make_form_data login.alias login.app_ticket in
  let uri = Uri.of_string (Printf.sprintf "https://%s/game/login/platformlogin" domain) in
  let* response, body =
    send_form ~headers:(Cohttp.Header.init_with "Content-Type" "application/x-www-form-urlencoded") uri form
  in
  let* body_str = Cohttp_lwt.Body.to_string body in
  let cookies = extract_cookies @@ Cohttp.Response.headers response in
  let application_gateway_affinity_cors = get_cookie_value cookies "ApplicationGatewayAffinityCORS" in
  let application_gateway_affinity = get_cookie_value cookies "ApplicationGatewayAffinity" in
  let reliclink = get_cookie_value cookies "reliclink" in
  let expires_on = 3600 + int_of_float (Unix.time ()) in
  let session_id = extract_session_id body_str in
  let c = { application_gateway_affinity; application_gateway_affinity_cors; reliclink; session_id; expires_on } in
  Lwt.return @@ Some c
;;
