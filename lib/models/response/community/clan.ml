type t =
  { result : Stub.Response.t
  ; clans : Stub.Clan.t list
  }

let to_json r =
  `Assoc [ "result", Stub.Response.to_json r.result; "clans", `List (List.map Stub.Clan.to_json r.clans) ]
;;

let from_json json =
  { result = Yojson.Basic.Util.(json |> member "result" |> Stub.Response.from_json)
  ; clans = Yojson.Basic.Util.(json |> member "clans" |> to_list |> List.map Stub.Clan.from_json)
  }
;;