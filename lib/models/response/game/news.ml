type t =
  { status : int
  ; news : Stub.Game.News.t list
  ; tail : Yojson.Basic.t list
  }

let to_json n = `List ([ `Int n.id; `List (List.map Stub.Game.News.to_json n.news) ] @ n.tail)

let from_json json =
  match json with
  | `List (`Int status :: `List items :: tail) -> { status; news = List.map Stub.Game.News.from_json items; tail }
  | _ -> failwith "Unexpected JSON format for the news response"
;;
