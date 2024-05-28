type t =
  { id : int
  ; name : string
  ; faction_id : int
  ; locstringid : int
  }

let to_json r =
  `Assoc
    [ "id", `Int r.id; "name", `String r.name; "faction_id", `Int r.faction_id; "locstringid", `Int r.locstringid ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { id = json |> member "id" |> to_int
  ; name = json |> member "name" |> to_string
  ; faction_id = json |> member "faction_id" |> to_int
  ; locstringid = json |> member "locstringid" |> to_int
  }
;;
