type t =
  { result : Stub.Response.t
  ; clan : Stub.Clan_info.t
  }

let to_json r = `Assoc [ "result", Stub.Response.to_json r.result; "clan", Stub.Clan_info.to_json r.clan ]

let from_json json =
  let open Yojson.Basic.Util in
  { result = json |> member "result" |> Stub.Response.from_json
  ; clan = json |> member "clan" |> Stub.Clan_info.from_json
  }
;;
