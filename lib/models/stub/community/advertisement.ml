type t =
  { id : int
  ; steamlobbyid : int
  ; goodoldgameslobbyid : int
  ; xboxsessionid : string
  ; host_profile_id : int
  ; state : int
  ; description : string
  ; visible : int
  ; mapname : string
  ; options : Advertisement_options.t option
  ; passwordprotected : int
  ; maxplayers : int
  ; slotinfo : Slot_info.t option
  ; matchtype_id : int
  ; matchmembers : Match_member.t list
  ; observernum : int
  ; observermax : int
  ; isobservable : int
  ; observerdelay : int
  ; hasobserverpassword : int
  ; servicetype : int
  ; relayserver_region : string
  }

let to_json a =
  `Assoc
    [ "id", `Int a.id
    ; "steamlobbyid", `Int a.steamlobbyid
    ; "goodoldgameslobbyid", `Int a.goodoldgameslobbyid
    ; "xboxsessionid", `String a.xboxsessionid
    ; "host_profile_id", `Int a.host_profile_id
    ; "state", `Int a.state
    ; "description", `String a.description
    ; "visible", `Int a.visible
    ; "mapname", `String a.mapname
    ; "options", `String "" (* TODO: Compress the list again *)
    ; "passwordprotected", `Int a.passwordprotected
    ; "maxplayers", `Int a.maxplayers
    ; "slotinfo", `String "" (* TODO: Compress the dict into a b64 zlib string again *)
    ; "matchtype_id", `Int a.matchtype_id
    ; "matchmembers", `List (List.map Match_member.to_json a.matchmembers)
    ; "observernum", `Int a.observernum
    ; "observermax", `Int a.observermax
    ; "isobservable", `Int a.isobservable
    ; "observerdelay", `Int a.observerdelay
    ; "hasobserverpassword", `Int a.hasobserverpassword
    ; "servicetype", `Int a.servicetype
    ; "relayserver_region", `String a.relayserver_region
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { id = json |> member "id" |> to_int
  ; steamlobbyid = json |> member "steamlobbyid" |> to_int
  ; goodoldgameslobbyid = json |> member "goodoldgameslobbyid" |> to_int
  ; xboxsessionid = json |> member "xboxsessionid" |> to_string
  ; host_profile_id = json |> member "host_profile_id" |> to_int
  ; state = json |> member "state" |> to_int
  ; description = json |> member "description" |> to_string
  ; visible = json |> member "visible" |> to_int
  ; mapname = json |> member "mapname" |> to_string
  ; options = json |> member "options" |> to_string |> Advertisement_options.from_zlib_b64_str
  ; passwordprotected = json |> member "passwordprotected" |> to_int
  ; maxplayers = json |> member "maxplayers" |> to_int
  ; slotinfo = json |> member "slotinfo" |> to_string |> Slot_info.from_zlib_b64_str
  ; matchtype_id = json |> member "matchtype_id" |> to_int
  ; matchmembers = json |> member "matchmembers" |> to_list |> List.map Match_member.from_json
  ; observernum = json |> member "observernum" |> to_int
  ; observermax = json |> member "observermax" |> to_int
  ; isobservable = json |> member "isobservable" |> to_int
  ; observerdelay = json |> member "observerdelay" |> to_int
  ; hasobserverpassword = json |> member "hasobserverpassword" |> to_int
  ; servicetype = json |> member "servicetype" |> to_int
  ; relayserver_region = json |> member "relayserver_region" |> to_string
  }
;;
