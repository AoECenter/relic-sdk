type t =
  { profile_id : int
  ; station_id : int
  ; team_id : int
  ; faction_id : int
  ; race_id : int
  ; rank_level : int
  ; rank_match_type_id : int
  ; time_per_frame_ms : int
  ; is_ready : bool
  ; status : int
  ; metadata : string
  }

let from_json json =
  let open Yojson.Basic.Util in
  { profile_id = json |> member "profileInfo.id" |> to_int
  ; station_id = json |> member "stationID" |> to_int
  ; team_id = json |> member "teamID" |> to_int
  ; faction_id = json |> member "factionID" |> to_int
  ; race_id = json |> member "raceID" |> to_int
  ; rank_level = json |> member "rankLevel" |> to_int
  ; rank_match_type_id = json |> member "rankMatchTypeID" |> to_int
  ; time_per_frame_ms = json |> member "timePerFrameMS" |> to_int
  ; is_ready = json |> member "isReady" |> to_bool
  ; status = json |> member "status" |> to_int
  ; metadata = json |> member "metaData" |> to_string
  }
;;

let to_json =
  (* TODO we need to re-encode and compress *)
  ""
;;
