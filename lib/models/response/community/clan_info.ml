type t =
  { result : Stub.Community.Response.t
  ; clan : Stub.Community.Clan_info.t
  }

let to_json r =
  `Assoc [ "result", Stub.Community.Response.to_json r.result; "clan", Stub.Community.Clan_info.to_json r.clan ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = json |> member "result" |> Stub.Community.Response.from_json
  ; clan = json |> member "clan" |> Stub.Community.Clan_info.from_json
  }
;;
