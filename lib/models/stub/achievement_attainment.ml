type achievement_attainment =
  { achievement_id : int
  ; achieveddate : int
  }

let to_json r = `Assoc [ "achievement_id", `Int r.achievement_id; "achieveddate", `Int r.achieveddate ]

let from_json json =
  { achievement_id = Yojson.Basic.Util.(json |> member "achievement_id" |> to_int)
  ; achieveddate = Yojson.Basic.Util.(json |> member "achieveddate" |> to_int)
  }
;;
