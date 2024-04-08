type t =
  { result : Stub.Response.t
  ; avatar_stats_for_profile : Stub.Avatar_stat.t list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Response.to_json r.result
    ; "avatarStatsForProfile", `List (List.map Stub.Avatar_stat.to_json r.avatar_stats_for_profile)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = Yojson.Basic.Util.(json |> member "result" |> Stub.Response.from_json)
  ; avatar_stats_for_profile =
      json |> member "avatarStatsForProfile" |> to_list |> List.map Stub.Avatar_stat.from_json
  }
;;
