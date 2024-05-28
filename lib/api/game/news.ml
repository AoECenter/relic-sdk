open Lwt.Syntax

let get game domain send =
  let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/game/news/getNews" () in
  let url = Uri.with_query' base_url [ "title", Data.Game.to_str game ] in
  let* json = send url in
  match json with Some j -> Lwt.return @@ Some (Models.Response.Game.News.from_json j) | None -> Lwt.return None
;;
