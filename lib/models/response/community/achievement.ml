type t =
  { result : Stub.Community.Response.t
  ; achievement_defs : Stub.Community.Achievement.t list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Community.Response.to_json r.result
    ; "achievementDefs", `List (List.map Stub.Community.Achievement.to_json r.achievement_defs)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = json |> member "result" |> Stub.Community.Response.from_json
  ; achievement_defs = json |> member "achievementDefs" |> to_list |> List.map Stub.Community.Achievement.from_json
  }
;;
