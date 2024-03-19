type achievement_attainment =
  { achievement_id : int
  ; achieveddate : int
  }

let to_json a = `Assoc [ "achievement_id", `Int a.achievement_id; "achieveddate", `Int a.achieveddate ]

let from_json json =
  { achievement_id = Yojson.Basic.Util.(json |> member "achievement_id" |> to_int)
  ; achieveddate = Yojson.Basic.Util.(json |> member "achieveddate" |> to_int)
  }
;;
