type t =
  { result : Stub.Community.Response.t
  ; communityEvents : Stub.Community.Community_event.t list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Community.Response.to_json r.result
    ; "communityEvents", `List (List.map Stub.Community.Community_event.to_json r.communityEvents)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = json |> member "result" |> Stub.Community.Response.from_json
  ; communityEvents =
      json |> member "communityEvents" |> to_list |> List.map Stub.Community.Community_event.from_json
  }
;;
