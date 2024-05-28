type t =
  { result : Stub.Community.Response.t
  ; avatar_stats_for_profile : Stub.Community.Avatar_stat.t list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Community.Response.to_json r.result
    ; "avatarStatsForProfile", `List (List.map Stub.Community.Avatar_stat.to_json r.avatar_stats_for_profile)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = Yojson.Basic.Util.(json |> member "result" |> Stub.Community.Response.from_json)
  ; avatar_stats_for_profile =
      json |> member "avatarStatsForProfile" |> to_list |> List.map Stub.Community.Avatar_stat.from_json
  }
;;
