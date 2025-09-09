type t =
  { result : Stub.Community.Response.t
  ; stat_groups : Stub.Community.Stat_group.t list
  ; leaderboard_stats : Stub.Community.Leaderboard_stat.t list
  }

let to_json l =
  `Assoc
    [ "result", Stub.Community.Response.to_json l.result
    ; "statGroups", `List (List.map Stub.Community.Stat_group.to_json l.stat_groups)
    ; "leaderboardStats", `List (List.map Stub.Community.Leaderboard_stat.to_json l.leaderboard_stats)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = json |> member "result" |> Stub.Community.Response.from_json
  ; stat_groups = json |> member "statGroups" |> to_list |> List.map Stub.Community.Stat_group.from_json
  ; leaderboard_stats =
      json |> member "leaderboardStats" |> to_list |> List.map Stub.Community.Leaderboard_stat.from_json
  }
;;
