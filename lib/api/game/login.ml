open Lwt.Syntax
open Data.Platform.Credentials

let platform_login credentials game domain send =
  let url = Uri.make ~scheme:"https" ~host:domain ~path:"/game/login/platformlogin" () in
  let* json = send url in
  match json with
  | Some j ->
    let model = Models.Response.Game.Platform_login.from_json j in
    Lwt.return @@ Some model
  | None -> Lwt.return None
;;
