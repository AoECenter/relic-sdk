type t =
  { code : int
  ; message : string
  }

let to_json r = `Assoc [ "code", `Int r.code; "message", `String r.message ]

let from_json json =
  { code = Yojson.Basic.Util.(json |> member "code" |> to_int)
  ; message = Yojson.Basic.Util.(json |> member "message" |> to_string)
  }
;;
