type t =
  { match_id : int
  ; profile_id : int
  ; ranking : int
  ; statgroup_id : int
  ; race_id : int
  ; teamid : int
  }

let to_json m =
  `Assoc
    [ "match_id", `Int m.match_id
    ; "profile_id", `Int m.profile_id
    ; "ranking", `Int m.ranking
    ; "statgroup_id", `Int m.statgroup_id
    ; "race_id", `Int m.race_id
    ; "teamid", `Int m.teamid
    ]
;;

let from_json json =
  { match_id = Yojson.Basic.Util.(json |> member "match_id" |> to_int)
  ; profile_id = Yojson.Basic.Util.(json |> member "profile_id" |> to_int)
  ; ranking = Yojson.Basic.Util.(json |> member "ranking" |> to_int)
  ; statgroup_id = Yojson.Basic.Util.(json |> member "statgroup_id" |> to_int)
  ; race_id = Yojson.Basic.Util.(json |> member "race_id" |> to_int)
  ; teamid = Yojson.Basic.Util.(json |> member "teamid" |> to_int)
  }
;;
