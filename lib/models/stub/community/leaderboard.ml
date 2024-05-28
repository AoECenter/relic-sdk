type t =
  { id : int
  ; name : string
  ; isranked : bool
  ; leaderboardmap : Leaderboard_map.t list
  }

let to_json l =
  `Assoc
    [ "id", `Int l.id
    ; "name", `String l.name
    ; "isranked", `Int (if l.isranked then 1 else 0)
    ; "leaderboardmap", `List (List.map Leaderboard_map.to_json l.leaderboardmap)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { id = json |> member "id" |> to_int
  ; name = json |> member "name" |> to_string
  ; isranked = json |> member "isranked" |> to_int == 1
  ; leaderboardmap = json |> member "leaderboardmap" |> to_list |> List.map Leaderboard_map.from_json
  }
;;
