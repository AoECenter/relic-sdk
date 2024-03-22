type t =
  { result : Stub.Response.t
  ; matches : Stub.Advertisement.t list
  ; avatars : Stub.Avatar.t list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Response.to_json r.result
    ; "avatars", `List (List.map Stub.Avatar.to_json r.avatars)
    ; "matches", `List (List.map Stub.Advertisement.to_json r.matches)
    ]
;;

let from_json json =
  { result = Yojson.Basic.Util.(json |> member "result" |> Stub.Response.from_json)
  ; matches = Yojson.Basic.Util.(json |> member "matches" |> to_list |> List.map Stub.Advertisement.from_json)
  ; avatars = Yojson.Basic.Util.(json |> member "avatars" |> to_list |> List.map Stub.Avatar.from_json)
  }
;;
