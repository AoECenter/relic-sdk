type t =
  { id : int
  ; image_url : string option
  ; title : string
  ; subtitle : string option
  ; description : string
  ; short_description : string
  ; long_description : string
  ; category : string
  ; start_time : int
  ; end_time : int
  }

let from_json json =
  match json with
  | `List
      [ id
      ; image_url
      ; title
      ; subtitle
      ; description
      ; short_description
      ; long_description
      ; category
      ; start_time
      ; end_time
      ] ->
    { id = Yojson.Basic.Util.to_int id
    ; image_url = Yojson.Basic.Util.to_string_option image_url
    ; title = Yojson.Basic.Util.to_string title
    ; subtitle = Yojson.Basic.Util.to_string_option subtitle
    ; description = Yojson.Basic.Util.to_string description
    ; short_description = Yojson.Basic.Util.to_string short_description
    ; long_description = Yojson.Basic.Util.to_string long_description
    ; category = Yojson.Basic.Util.to_string category
    ; start_time = Yojson.Basic.Util.to_int start_time
    ; end_time = Yojson.Basic.Util.to_int end_time
    }
  | _ -> failwith "Unexpected news item format"
;;

let to_json n =
  `List
    [ `Int n.id
    ; (match n.image_url with Some url -> `String url | None -> `Null)
    ; `String n.title
    ; (match n.subtitle with Some sub -> `String sub | None -> `Null)
    ; `String n.description
    ; `String n.short_description
    ; `String n.long_description
    ; `String n.category
    ; `Int n.start_time
    ; `Int n.end_time
    ]
;;
