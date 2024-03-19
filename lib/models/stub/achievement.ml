type achievement =
  { id : int
  ; name : string
  ; name_locstringid : int
  ; description_locstringid : int
  ; icon : string
  ; timemodified : int
  ; deleted : int
  ; itembundle_id : int
  }

let to_json a =
  `Assoc
    [ "id", `Int a.id
    ; "name", `String a.name
    ; "name_locstringid", `Int a.name_locstringid
    ; "description_locstringid", `Int a.description_locstringid
    ; "icon", `String a.icon
    ; "timemodified", `Int a.timemodified
    ; "deleted", `Int a.deleted
    ; "itembundle_id", `Int a.itembundle_id
    ]
;;

let from_json json =
  { id = Yojson.Basic.Util.(json |> member "id" |> to_int)
  ; name = Yojson.Basic.Util.(json |> member "name" |> to_string)
  ; name_locstringid = Yojson.Basic.Util.(json |> member "name_locstringid" |> to_int)
  ; description_locstringid = Yojson.Basic.Util.(json |> member "description_locstringid" |> to_int)
  ; icon = Yojson.Basic.Util.(json |> member "icon" |> to_string)
  ; timemodified = Yojson.Basic.Util.(json |> member "timemodified" |> to_int)
  ; deleted = Yojson.Basic.Util.(json |> member "deleted" |> to_int)
  ; itembundle_id = Yojson.Basic.Util.(json |> member "itembundle_id" |> to_int)
  }
;;
