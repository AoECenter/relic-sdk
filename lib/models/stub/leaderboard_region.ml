type t =
  { id : int
  ; name : string
  ; locstringid : int
  }

let to_json r = `Assoc [ "id", `Int r.id; "name", `String r.name; "locstringid", `Int r.locstringid ]

let from_json json =
  let open Yojson.Basic.Util in
  { id = json |> member "id" |> to_int
  ; name = json |> member "name" |> to_string
  ; locstringid = json |> member "locstringid" |> to_int
  }
;;
