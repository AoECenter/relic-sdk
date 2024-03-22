type t =
  { result : Stub.Response.t
  ; achievement_defs : Stub.Achievement.t list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Response.to_json r.result
    ; "achievementDefs", `List (List.map Stub.Achievement.to_json r.achievement_defs)
    ]
;;

let from_json json =
  { result = Yojson.Basic.Util.(json |> member "result" |> Stub.Response.from_json)
  ; achievement_defs =
      Yojson.Basic.Util.(json |> member "achievementDefs" |> to_list |> List.map Stub.Achievement.from_json)
  }
;;
