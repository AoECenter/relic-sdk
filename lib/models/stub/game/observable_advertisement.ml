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
  ; metadata : Yojson.Basic.t list
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
      [ match_id
      ; int1
      ; string1
      ; host_relic_link_id
      ; int2
      ; title
      ; description
      ; int3
      ; map
      ; options
      ; int4
      ; int5
      ; slotinfo
      ; int6
      ; metadata
      ; int7
      ; int8
      ; int9
      ; int10
      ; int11
      ; int12
      ; time_started
      ; server
      ; unknown
      ] ->
    { match_id = Yojson.Basic.Util.to_int match_id
    ; int1 = Yojson.Basic.Util.to_int int1
    ; string1 = Yojson.Basic.Util.to_string string1
    ; host_relic_link_id = Yojson.Basic.Util.to_int host_relic_link_id
    ; int2 = Yojson.Basic.Util.to_int int2
    ; title = Yojson.Basic.Util.to_string title
    ; description = Yojson.Basic.Util.to_string description
    ; int3 = Yojson.Basic.Util.to_int int3
    ; map = Yojson.Basic.Util.to_string map
    ; options = Yojson.Basic.Util.to_string options (* TODO: Parse this*)
    ; int4 = Yojson.Basic.Util.to_int int4
    ; int5 = Yojson.Basic.Util.to_int int5
    ; slotinfo = Yojson.Basic.Util.to_string slotinfo (* TODO: Parse this*)
    ; int6 = Yojson.Basic.Util.to_int int6
    ; metadata = Yojson.Basic.Util.to_list metadata
    ; int7 = Yojson.Basic.Util.to_int int7
    ; int8 = Yojson.Basic.Util.to_int int8
    ; int9 = Yojson.Basic.Util.to_int int9
    ; int10 = Yojson.Basic.Util.to_int int10
    ; int11 = Yojson.Basic.Util.to_int int11
    ; int12 = Yojson.Basic.Util.to_int int12
    ; time_started = Yojson.Basic.Util.to_int time_started
    ; server = Yojson.Basic.Util.to_string server
    ; unknown = Yojson.Basic.Util.to_int_option unknown
    }
  | _ -> failwith "Unexpected observable advertisement format"
;;

let to_json n =
  `List
    [ `Int n.match_id
    ; `Int n.int1
    ; `String n.string1
    ; `Int n.host_relic_link_id
    ; `Int n.int2
    ; `String n.title
    ; `String n.description
    ; `Int n.int3
    ; `String n.map
    ; `String n.options
    ; `Int n.int4
    ; `Int n.int5
    ; `String n.slotinfo
    ; `Int n.int6
    ; `List n.metadata
    ; `Int n.int7
    ; `Int n.int8
    ; `Int n.int9
    ; `Int n.int10
    ; `Int n.int11
    ; `Int n.int12
    ; `String n.server
    ; `Int n.time_started
    ; (match n.unknown with Some u -> `Int u | None -> `Null)
    ]
;;
