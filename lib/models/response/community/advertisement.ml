type t =
  { result : Stub.Community.Response.t
  ; matches : Stub.Community.Advertisement.t list
  ; avatars : Stub.Community.Avatar.t list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Community.Response.to_json r.result
    ; "avatars", `List (List.map Stub.Community.Avatar.to_json r.avatars)
    ; "matches", `List (List.map Stub.Community.Advertisement.to_json r.matches)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = json |> member "result" |> Stub.Community.Response.from_json
  ; matches = json |> member "matches" |> to_list |> List.map Stub.Community.Advertisement.from_json
  ; avatars = json |> member "avatars" |> to_list |> List.map Stub.Community.Avatar.from_json
  }
;;
