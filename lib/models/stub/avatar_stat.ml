type t =
  { profile_id : int
  ; avatarstat_id : int
  ; value : int
  ; lastupdated : int
  }

let to_json a =
  `Assoc
    [ "profile_id", `Int a.profile_id
    ; "avatarstat_id", `Int a.avatarstat_id
    ; "value", `Int a.value
    ; "lastupdated", `Int a.lastupdated
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { profile_id = json |> member "profile_id" |> to_int
  ; avatarstat_id = json |> member "avatarstat_id" |> to_int
  ; value = json |> member "value" |> to_int
  ; lastupdated = json |> member "lastupdated" |> to_int
  }
;;
