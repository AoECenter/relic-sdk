type t =
  { result : Stub.Response.t
  ; stat_groups : Stub.Stat_group.t list
  ; leaderboard_stats : Stub.Leaderboard_stat.t list
  ; rank_total : int
  }

let to_json l =
  `Assoc
    [ "result", Stub.Response.to_json l.result
    ; "statGroups", `List (List.map Stub.Stat_group.to_json l.stat_groups)
    ; "leaderboardStats", `List (List.map Stub.Leaderboard_stat.to_json l.leaderboard_stats)
    ; "rankTotal", `Int l.rank_total
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = json |> member "result" |> Stub.Response.from_json
  ; stat_groups = json |> member "statGroups" |> to_list |> List.map Stub.Stat_group.from_json
  ; leaderboard_stats = json |> member "leaderboardStats" |> to_list |> List.map Stub.Leaderboard_stat.from_json
  ; rank_total = json |> member "rankTotal" |> to_int
  }
;;
