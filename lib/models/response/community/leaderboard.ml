type t =
  { result : Stub.Community.Response.t
  ; leaderboards : Stub.Community.Leaderboard.t list
  ; match_types : Stub.Community.Match_type.t list
  ; races : Stub.Community.Race.t list
  ; leaderboard_regions : Stub.Community.Leaderboard_region.t list
  (*; factions : string list (* Theres no docs for this so i have to disable it for now. It's been empty for every
    game. *) *)
  }

let to_json r =
  `Assoc
    [ "result", Stub.Community.Response.to_json r.result
    ; "leaderboards", `List (List.map Stub.Community.Leaderboard.to_json r.leaderboards)
    ; "matchTypes", `List (List.map Stub.Community.Match_type.to_json r.match_types)
    ; "races", `List (List.map Stub.Community.Race.to_json r.races)
    ; "leaderboardRegions", `List (List.map Stub.Community.Leaderboard_region.to_json r.leaderboard_regions)
    ]
;;

let from_json json =
  { result = Yojson.Basic.Util.(json |> member "result" |> Stub.Community.Response.from_json)
  ; leaderboards =
      Yojson.Basic.Util.(json |> member "leaderboards" |> to_list |> List.map Stub.Community.Leaderboard.from_json)
  ; match_types =
      Yojson.Basic.Util.(json |> member "matchTypes" |> to_list |> List.map Stub.Community.Match_type.from_json)
  ; races = Yojson.Basic.Util.(json |> member "races" |> to_list |> List.map Stub.Community.Race.from_json)
  ; leaderboard_regions =
      Yojson.Basic.Util.(
        json |> member "leaderboardRegions" |> to_list |> List.map Stub.Community.Leaderboard_region.from_json)
  }
;;
