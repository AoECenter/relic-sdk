type t =
  { result : Stub.Response.t
  ; leaderboards : Stub.Leaderboard.t list
  ; match_types : Stub.Match_type.t list
  ; races : Stub.Race.t list
  ; leaderboard_regions : Stub.Leaderboard_region.t list
  (*; factions : string list (* Theres no docs for this so i have to disable it for now. It's been empty for every
    game. *) *)
  }

let to_json r =
  `Assoc
    [ "result", Stub.Response.to_json r.result
    ; "leaderboards", `List (List.map Stub.Leaderboard.to_json r.leaderboards)
    ; "matchTypes", `List (List.map Stub.Match_type.to_json r.match_types)
    ; "races", `List (List.map Stub.Race.to_json r.races)
    ; "leaderboardRegions", `List (List.map Stub.Leaderboard_region.to_json r.leaderboard_regions)
    ]
;;

let from_json json =
  { result = Yojson.Basic.Util.(json |> member "result" |> Stub.Response.from_json)
  ; leaderboards =
      Yojson.Basic.Util.(json |> member "leaderboards" |> to_list |> List.map Stub.Leaderboard.from_json)
  ; match_types = Yojson.Basic.Util.(json |> member "matchTypes" |> to_list |> List.map Stub.Match_type.from_json)
  ; races = Yojson.Basic.Util.(json |> member "races" |> to_list |> List.map Stub.Race.from_json)
  ; leaderboard_regions =
      Yojson.Basic.Util.(
        json |> member "leaderboardRegions" |> to_list |> List.map Stub.Leaderboard_region.from_json)
  }
;;
