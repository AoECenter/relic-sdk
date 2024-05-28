type t =
  { match_id : int
  ; int1 : int
  ; string1 : string
  ; host_relic_link_id : int
  ; int2 : int
  ; title : string
  ; description : string
  ; int3 : int
  ; map : string
  ; options : string
  ; int4 : int
  ; int5 : int
  ; slotinfo : string
  ; int6 : int
  ; metadata : Yojson.Basic.t
  ; int7 : int
  ; int8 : int
  ; int9 : int
  ; int10 : int
  ; int11 : int
  ; int12 : int
  ; time_started : int
  ; server : string
  ; unknown : int option
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
