open Lwt.Syntax

let get ?(start = 0) ?(count = 100) game domain send =
  let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/advertisement/findAdvertisements" () in
  let url =
    Uri.with_query'
      base_url
      [ "title", Data.Game.to_str game; "start", string_of_int start; "count", string_of_int count ]
  in
  let* json = send url in
  match json with
  | Some j ->
    let model = Models.Response.Community.Advertisement.from_json j in
    Lwt.return @@ Some model
  | None -> Lwt.return None
;;
