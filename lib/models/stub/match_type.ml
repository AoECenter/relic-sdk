type t =
  { id : int
  ; name : string
  ; locstringid : int
  }

let to_json m = `Assoc [ "id", `Int m.id; "name", `String m.name; "locstringid", `Int m.locstringid ]

let from_json json =
  let open Yojson.Basic.Util in
  { id = json |> member "id" |> to_int
  ; name = json |> member "name" |> to_string
  ; locstringid = json |> member "locstringid" |> to_int
  }
;;
