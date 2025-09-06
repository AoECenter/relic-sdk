type t =
  { matchhistory_id : int
  ; profile_id : int
  ; resulttype : int
  ; teamid : int
  ; race_id : int
  ; xpgained : int (* ; counters: {} (* Empty object, no idea what it is for *) *)
  ; matchstartdate : int
  }

let to_json m =
  `Assoc
    [ "matchhistory_id", `Int m.matchhistory_id
    ; "profile_id", `Int m.profile_id
    ; "resulttype", `Int m.resulttype
    ; "teamid", `Int m.teamid
    ; "race_id", `Int m.race_id
    ; "xpgained", `Int m.xpgained
    ; "matchstartdate", `Int m.matchstartdate
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { matchhistory_id = json |> member "matchhistory_id" |> to_int
  ; profile_id = json |> member "profile_id" |> to_int
  ; resulttype = json |> member "resulttype" |> to_int
  ; teamid = json |> member "teamid" |> to_int
  ; race_id = json |> member "race_id" |> to_int
  ; xpgained = json |> member "xpgained" |> to_int
  ; matchstartdate = json |> member "matchstartdate" |> to_int
  }
;;
