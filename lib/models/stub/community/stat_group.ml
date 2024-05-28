type t =
  { id : int
  ; name : string
  ; type_ : int
  ; members : Avatar.t list
  }

let to_json s =
  `Assoc
    [ "id", `Int s.id
    ; "name", `String s.name
    ; "type", `Int s.type_
    ; "members", `List (List.map Avatar.to_json s.members)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { id = json |> member "id" |> to_int
  ; name = json |> member "name" |> to_string
  ; type_ = json |> member "type" |> to_int
  ; members = json |> member "members" |> to_list |> List.map Avatar.from_json
  }
;;
