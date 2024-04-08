type t =
  { result : Stub.Response.t
  ; communityEvents : Stub.Community_event.t list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Response.to_json r.result
    ; "communityEvents", `List (List.map Stub.Community_event.to_json r.communityEvents)
    ]
;;

let from_json json =
  { result = Yojson.Basic.Util.(json |> member "result" |> Stub.Response.from_json)
  ; communityEvents =
      Yojson.Basic.Util.(json |> member "communityEvents" |> to_list |> List.map Stub.Community_event.from_json)
  }
;;
