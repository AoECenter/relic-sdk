open Lwt.Syntax

let get_available game domain send =
  let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/achievement/getAvailableAchievements" () in
  let url = Uri.with_query' base_url [ "title", Data.Game.to_str game ] in
  let* json = send url in
  match json with
  | Some j ->
    let model = Models.Response.Community.Achievement.from_json j in
    Lwt.return @@ Some model
  | None -> Lwt.return None
;;

let get ?(profile_ids=[]) game domain send =
  match profile_ids with
  | [] -> Lwt.fail_with "Profile IDs list cannot be empty"
  | _ids ->
    let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/achievement/getAchievements" () in
    let url =
      Uri.with_query' base_url [ "title", Data.Game.to_str game; "profileids", Data.Query.encode_lst_i profile_ids ]
    in
    let* json = send url in
    match json with
    | Some j ->
      let model = Models.Response.Community.Achievement_attainment.from_json j in
      Lwt.return @@ Some model
    | None -> Lwt.return None
;;
