open Lwt.Syntax

let get game domain send =
  let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/news/getNews" () in
  let url = Uri.with_query' base_url [ "title", Data.Game.to_str game ] in
  let* json = send url in
  match json with
  | Some j ->
    Lwt.return
    @@ Data.Json.try_parse_as
         (module Models.Response.Community.News : Data.Json.JsonParsable
           with type t = Models.Response.Community.News.t)
         j
  | None -> Lwt.return None
;;
