open Lwt.Syntax

let get ?(name = "") ?(tags = []) ?(join_policies = []) game domain send =
  let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/achievement/getAchievements" () in
  let url =
    Uri.with_query'
      base_url
      [ "title", Data.Game.to_str game
      ; "name", name
      ; "tags", Data.Query.encode_lst_s tags
      ; "joinPolicies", Data.Query.encode_lst_i @@ List.map Models.Stub.Join_policy.to_int join_policies
      ]
  in
  let* json = send url in
  match json with
  | Some j ->
    let model = Models.Response.Community.Clan.from_json j in
    Lwt.return @@ Some model
  | None -> Lwt.return None
;;
