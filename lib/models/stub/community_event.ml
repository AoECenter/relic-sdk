type t =
  { id : int
  ; name : string
  ; start : int
  ; end_ : int (* `end` is a reserved keyword in OCaml, hence the underscore *)
  ; expiryTime : int
  ; scheduledstarttime : int
  ; scheduledendtime : int
  ; scheduledexpirytime : int
  ; actualstarttime : int
  ; customdata : string
  ; eventstate : int
  ; localizedName : string
  }

let to_json e =
  `Assoc
    [ "id", `Int e.id
    ; "name", `String e.name
    ; "start", `Int e.start
    ; "end", `Int e.end_
    ; "expiryTime", `Int e.expiryTime
    ; "scheduledstarttime", `Int e.scheduledstarttime
    ; "scheduledendtime", `Int e.scheduledendtime
    ; "scheduledexpirytime", `Int e.scheduledexpirytime
    ; "actualstarttime", `Int e.actualstarttime
    ; "customdata", `String e.customdata
    ; "eventstate", `Int e.eventstate
    ; "localizedName", `String e.localizedName
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { id = json |> member "id" |> to_int
  ; name = json |> member "name" |> to_string
  ; start = json |> member "start" |> to_int
  ; end_ = json |> member "end" |> to_int
  ; expiryTime = json |> member "expiryTime" |> to_int
  ; scheduledstarttime = json |> member "scheduledstarttime" |> to_int
  ; scheduledendtime = json |> member "scheduledendtime" |> to_int
  ; scheduledexpirytime = json |> member "scheduledexpirytime" |> to_int
  ; actualstarttime = json |> member "actualstarttime" |> to_int
  ; customdata = json |> member "customdata" |> to_string
  ; eventstate = json |> member "eventstate" |> to_int
  ; localizedName = json |> member "localizedName" |> to_string
  }
;;
