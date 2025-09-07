open Lwt.Syntax

let get_available_leaderboards game domain send =
  let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/leaderboard/GetAvailableLeaderboards" () in
  let url = Uri.with_query' base_url [ "title", Data.Game.to_str game; "format", "json" ] in
  let* json = send url in
  match json with
  | Some j ->
    let model = Models.Response.Community.Leaderboard.from_json j in
    Lwt.return @@ Some model
  | None -> Lwt.return None
;;

let get game domain send = get_available_leaderboards game domain send

let get_avatar ~profile_ids game domain send =
  match profile_ids with
  | [] -> Lwt.fail_with "Profile IDs list cannot be empty"
  | _ids ->
    let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/leaderboard/GetAvatarStatForProfile" () in
    let url =
      Uri.with_query'
        base_url
        [ "title", Data.Game.to_str game; "profile_ids", Data.Query.encode_lst_i profile_ids; "format", "json" ]
    in
    let* json = send url in
    (match json with
     | Some j ->
       let model = Models.Response.Community.Avatar_stat.from_json j in
       Lwt.return @@ Some model
     | None -> Lwt.return None)
;;

let get_leaderboard_2
      ?(sortby = Models.Stub.Community.Leaderboard_sorting.ByRating)
      ?(platform = "PC_STEAM")
      ?(leaderboard_id = 3)
      ?(start = 1)
      ?(count = 100)
      game
      domain
      send
  =
  let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/leaderboard/getLeaderboard2" () in
  let url =
    Uri.with_query'
      base_url
      [ "title", Data.Game.to_str game
      ; "sortBy", string_of_int @@ Models.Stub.Community.Leaderboard_sorting.to_int sortby
      ; "platform", platform
      ; "leaderboard_id", string_of_int leaderboard_id
      ; "start", string_of_int start
      ; "count", string_of_int count
      ; "format", "json"
      ]
  in
  let* json = send url in
  match json with
  | Some j ->
    let model = Models.Response.Community.Leaderboard2.from_json j in
    Lwt.return @@ Some model
  | None -> Lwt.return None
;;

let get_recent_match_history ~profile_ids game domain send =
  match profile_ids with
  | [] -> Lwt.fail_with "Profile IDs list cannot be empty"
  | _ ->
    let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/leaderboard/getRecentMatchHistory" () in
    let profile_ids_j : Yojson.Basic.t = `List (List.map (fun i -> `Int i) profile_ids) in
    let url =
      Uri.with_query'
        base_url
        [ "title", Data.Game.to_str game; "format", "json"; "profile_ids", Yojson.Basic.to_string profile_ids_j ]
    in
    let* json = send url in
    (match json with
     | Some j ->
       let model = Models.Response.Community.Recent_match_history.from_json j in
       Lwt.return @@ Some model
     | None -> Lwt.return None)
;;

let get_personal_stat ~profile_ids game domain send =
  match profile_ids with
  | [] -> Lwt.fail_with "Profile IDs list cannot be empty"
  | _ ->
    let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/leaderboard/getPersonalStat" () in
    let profile_ids_j : Yojson.Basic.t = `List (List.map (fun i -> `Int i) profile_ids) in
    let url =
      Uri.with_query'
        base_url
        [ "title", Data.Game.to_str game; "format", "json"; "profile_ids", Yojson.Basic.to_string profile_ids_j ]
    in
    let* json = send url in
    (match json with
     | Some j ->
       let model = Models.Response.Community.Personal_stat.from_json j in
       Lwt.return @@ Some model
     | None -> Lwt.return None)
;;
