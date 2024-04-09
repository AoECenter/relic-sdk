open Lwt.Syntax

let find ?(name = "") ?(tags = []) ?(join_policies = []) ?(start = 1) ?(count = 100) game domain send =
  let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/clan/find" () in
  let url =
    Uri.with_query'
      base_url
      [ "title", Data.Game.to_str game
      ; "name", name
      ; "tags", Data.Query.encode_lst_s tags
      ; "joinPolicies", Data.Query.encode_lst_i @@ List.map Models.Stub.Join_policy.to_int join_policies
      ; "start", string_of_int start
      ; "count", string_of_int count
      ]
  in
  let* json = send url in
  match json with
  | Some j ->
    let model = Models.Response.Community.Clan.from_json j in
    Lwt.return @@ Some model
  | None -> Lwt.return None
;;

let get name game domain send =
  let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/clan/getClanInfoFull" () in
  let url = Uri.with_query' base_url [ "title", Data.Game.to_str game; "name", name ] in
  let* json = send url in
  match json with
  | Some j ->
    let model = Models.Response.Community.Clan_info.from_json j in
    Lwt.return @@ Some model
  | None -> Lwt.return None
;;
