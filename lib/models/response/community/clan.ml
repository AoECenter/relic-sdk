type t =
  { result : Stub.Community.Response.t
  ; clans : Stub.Community.Clan.t list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Community.Response.to_json r.result
    ; "clans", `List (List.map Stub.Community.Clan.to_json r.clans)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = json |> member "result" |> Stub.Community.Response.from_json
  ; clans = json |> member "clans" |> to_list |> List.map Stub.Community.Clan.from_json
  }
;;
