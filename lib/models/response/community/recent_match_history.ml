type t =
  { result : Stub.Community.Response.t
  ; match_history_stats : Stub.Community.Match_history_stats.t list
  ; profiles : Stub.Community.Avatar.t list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Community.Response.to_json r.result
    ; "matchHistoryStats", `List (List.map Stub.Community.Match_history_stats.to_json r.match_history_stats)
    ; "profiles", `List (List.map Stub.Community.Avatar.to_json r.profiles)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = Yojson.Basic.Util.(json |> member "result" |> Stub.Community.Response.from_json)
  ; match_history_stats =
      Yojson.Basic.Util.(
        json |> member "matchHistoryStats" |> to_list |> List.map Stub.Community.Match_history_stats.from_json)
  ; profiles = json |> member "profiles" |> to_list |> List.map Stub.Community.Avatar.from_json
  }
;;
