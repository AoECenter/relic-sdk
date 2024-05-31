type t =
  { status : int
  ; advertisements : Stub.Game.Observable_advertisement.t list
  ; members : Stub.Game.Observable_advertisement_member.t list
  ; tail : Yojson.Basic.t list
  }

let to_json a =
  `List
    ([ `Int a.status
     ; `List (List.map Stub.Game.Observable_advertisement.to_json a.advertisements)
     ; `List (List.map Stub.Game.Observable_advertisement_member.to_json a.members)
     ]
     @ a.tail)
;;

let from_json json =
  match json with
  | `List (`Int status :: `List items :: `List members :: tail) ->
    { status
    ; advertisements = List.map Stub.Game.Observable_advertisement.from_json items
    ; members = List.map Stub.Game.Observable_advertisement_member.from_json members
    ; tail
    }
  | _ -> failwith "Unexpected JSON format for the observable advertisements response"
;;
