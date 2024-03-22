type t =
  { profile_id : int
  ; name : string
  ; alias : string
  ; personal_statgroup_id : int
  ; xp : int
  ; level : int
  ; leaderboardregion_id : int
  ; country : string
  }

let to_json a =
  `Assoc
    [ "profile_id", `Int a.profile_id
    ; "name", `String a.name
    ; "alias", `String a.alias
    ; "personal_statgroup_id", `Int a.personal_statgroup_id
    ; "xp", `Int a.xp
    ; "level", `Int a.level
    ; "leaderboardregion_id", `Int a.leaderboardregion_id
    ; "country", `String a.country
    ]
;;

let from_json json =
  { profile_id = Yojson.Basic.Util.(json |> member "profile_id" |> to_int)
  ; name = Yojson.Basic.Util.(json |> member "name" |> to_string)
  ; alias = Yojson.Basic.Util.(json |> member "alias" |> to_string)
  ; personal_statgroup_id = Yojson.Basic.Util.(json |> member "personal_statgroup_id" |> to_int)
  ; xp = Yojson.Basic.Util.(json |> member "xp" |> to_int)
  ; level = Yojson.Basic.Util.(json |> member "level" |> to_int)
  ; leaderboardregion_id = Yojson.Basic.Util.(json |> member "leaderboardregion_id" |> to_int)
  ; country = Yojson.Basic.Util.(json |> member "country" |> to_string)
  }
;;
