type t =
  { statgroup_id : int
  ; leaderboard_id : int
  ; wins : int
  ; losses : int
  ; streak : int
  ; disputes : int
  ; drops : int
  ; rank : int
  ; ranktotal : int
  ; ranklevel : int
  ; rating : int
  ; regionrank : int
  ; regionranktotal : int
  ; lastmatchdate : int
  ; highestrank : int
  ; highestranklevel : int
  ; highestrating : int
  }

let to_json sg =
  `Assoc
    [ "statgroup_id", `Int sg.statgroup_id
    ; "leaderboard_id", `Int sg.leaderboard_id
    ; "wins", `Int sg.wins
    ; "losses", `Int sg.losses
    ; "streak", `Int sg.streak
    ; "disputes", `Int sg.disputes
    ; "drops", `Int sg.drops
    ; "rank", `Int sg.rank
    ; "ranktotal", `Int sg.ranktotal
    ; "ranklevel", `Int sg.ranklevel
    ; "rating", `Int sg.rating
    ; "regionrank", `Int sg.regionrank
    ; "regionranktotal", `Int sg.regionranktotal
    ; "lastmatchdate", `Int sg.lastmatchdate
    ; "highestrank", `Int sg.highestrank
    ; "highestranklevel", `Int sg.highestranklevel
    ; "highestrating", `Int sg.highestrating
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { statgroup_id = json |> member "statgroup_id" |> to_int
  ; leaderboard_id = json |> member "leaderboard_id" |> to_int
  ; wins = json |> member "wins" |> to_int
  ; losses = json |> member "losses" |> to_int
  ; streak = json |> member "streak" |> to_int
  ; disputes = json |> member "disputes" |> to_int
  ; drops = json |> member "drops" |> to_int
  ; rank = json |> member "rank" |> to_int
  ; ranktotal = json |> member "ranktotal" |> to_int
  ; ranklevel = json |> member "ranklevel" |> to_int
  ; rating = json |> member "rating" |> to_int
  ; regionrank = json |> member "regionrank" |> to_int
  ; regionranktotal = json |> member "regionranktotal" |> to_int
  ; lastmatchdate = json |> member "lastmatchdate" |> to_int
  ; highestrank = json |> member "highestrank" |> to_int
  ; highestranklevel = json |> member "highestranklevel" |> to_int
  ; highestrating = json |> member "highestrating" |> to_int
  }
;;
