type t =
  { status : int
  ; advertisements : Stub.Game.Observable_advertisement.t list (* ; avatars : Yojson.Basic.t list *)
  ; tail : Yojson.Basic.t list
  }

let to_json a =
  `List ([ `Int a.status; `List (List.map Stub.Game.Observable_advertisement.to_json a.advertisements) ] @ a.tail)
;;

let from_json json =
  match json with
  | `List (`Int status :: `List items :: tail) ->
    { status; advertisements = List.map Stub.Game.Observable_advertisement.from_json items; tail }
  | _ -> failwith "Unexpected JSON format for the observable advertisements response"
;;
