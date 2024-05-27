type t =
  { matchtype_id : int
  ; statgroup_type : int
  ; race_id : int
  }

let to_json m =
  `Assoc [ "matchtype_id", `Int m.matchtype_id; "statgroup_type", `Int m.statgroup_type; "race_id", `Int m.race_id ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { matchtype_id = json |> member "matchtype_id" |> to_int
  ; statgroup_type = json |> member "statgroup_type" |> to_int
  ; race_id = json |> member "race_id" |> to_int
  }
;;
