type t =
  { id : int
  ; creator_profile_id : int
  ; mapname : string
  ; maxplayers : int
  ; matchtype_id : int
  ; options : string (* ; slotinfo: string (* base64 encoded field, no idea what it contains *) *)
  ; description : string
  ; startgametime : int
  ; completiontime : int
  ; observertotal : int
  ; match_history_report_results : Match_history_report_results.t list
  }

let to_json m =
  `Assoc
    [ "id", `Int m.id
    ; "creator_profile_id", `Int m.creator_profile_id
    ; "mapname", `String m.mapname
    ; "maxplayers", `Int m.maxplayers
    ; "matchtype_id", `Int m.matchtype_id
    ; "options", `String m.options
    ; "description", `String m.description
    ; "startgametime", `Int m.startgametime
    ; "completiontime", `Int m.completiontime
    ; "observertotal", `Int m.observertotal
    ; ( "matchhistoryreportresults"
      , `List (List.map Match_history_report_results.to_json m.match_history_report_results) )
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { id = json |> member "id" |> to_int
  ; creator_profile_id = json |> member "creator_profile_id" |> to_int
  ; mapname = json |> member "mapname" |> to_string
  ; maxplayers = json |> member "maxplayers" |> to_int
  ; matchtype_id = json |> member "matchtype_id" |> to_int
  ; options = json |> member "options" |> to_string
  ; description = json |> member "description" |> to_string
  ; startgametime = json |> member "startgametime" |> to_int
  ; completiontime = json |> member "completiontime" |> to_int
  ; observertotal = json |> member "observertotal" |> to_int
  ; match_history_report_results =
      json |> member "matchhistoryreportresults" |> to_list |> List.map Match_history_report_results.from_json
  }
;;
