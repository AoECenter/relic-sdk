type t =
  { int1 : int
  ; profile_id : int
  ; platform_id : string
  ; icon : string
  ; name : string
  ; string1 : string
  ; int2 : int
  ; int3 : int
  ; int4 : int
  ; int5 : int
  ; int_null : int option
  ; string2 : string
  ; int6 : int
  ; list1 : Yojson.Basic.t list
  }

let from_json json =
  match json with
  | `List
      [ int1; profile_id; platform_id; icon; name; string1; int2; int3; int4; int5; int_null; string2; int6; list1 ]
    ->
    { int1 = Yojson.Basic.Util.to_int int1
    ; profile_id = Yojson.Basic.Util.to_int profile_id
    ; platform_id = Yojson.Basic.Util.to_string platform_id
    ; icon = Yojson.Basic.Util.to_string icon
    ; name = Yojson.Basic.Util.to_string name
    ; string1 = Yojson.Basic.Util.to_string string1
    ; int2 = Yojson.Basic.Util.to_int int2
    ; int3 = Yojson.Basic.Util.to_int int3
    ; int4 = Yojson.Basic.Util.to_int int4
    ; int5 = Yojson.Basic.Util.to_int int5
    ; int_null = Yojson.Basic.Util.to_int_option int_null
    ; string2 = Yojson.Basic.Util.to_string string2
    ; int6 = Yojson.Basic.Util.to_int int6
    ; list1 = Yojson.Basic.Util.to_list list1
    }
  | _ -> failwith "Unexpected observable advertisement member format"
;;

let to_json n =
  `List
    [ `Int n.int1
    ; `Int n.profile_id
    ; `String n.platform_id
    ; `String n.icon
    ; `String n.name
    ; `String n.string1
    ; `Int n.int2
    ; `Int n.int3
    ; `Int n.int4
    ; `Int n.int5
    ; (match n.int_null with Some i -> `Int i | None -> `Null)
    ; `String n.string2
    ; `Int n.int6
    ; `List n.list1
    ]
;;
