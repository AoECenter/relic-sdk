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
  ; options : string
  ; passwordprotected : int
  ; maxplayers : int
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
    ; "options", `String a.options
    ; "passwordprotected", `Int a.passwordprotected
    ; "maxplayers", `Int a.maxplayers
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
  { id = Yojson.Basic.Util.(json |> member "id" |> to_int)
  ; steamlobbyid = Yojson.Basic.Util.(json |> member "steamlobbyid" |> to_int)
  ; goodoldgameslobbyid = Yojson.Basic.Util.(json |> member "goodoldgameslobbyid" |> to_int)
  ; xboxsessionid = Yojson.Basic.Util.(json |> member "xboxsessionid" |> to_string)
  ; host_profile_id = Yojson.Basic.Util.(json |> member "host_profile_id" |> to_int)
  ; state = Yojson.Basic.Util.(json |> member "state" |> to_int)
  ; description = Yojson.Basic.Util.(json |> member "description" |> to_string)
  ; visible = Yojson.Basic.Util.(json |> member "visible" |> to_int)
  ; mapname = Yojson.Basic.Util.(json |> member "mapname" |> to_string)
  ; options = Yojson.Basic.Util.(json |> member "options" |> to_string)
  ; passwordprotected = Yojson.Basic.Util.(json |> member "passwordprotected" |> to_int)
  ; maxplayers = Yojson.Basic.Util.(json |> member "maxplayers" |> to_int)
  ; matchtype_id = Yojson.Basic.Util.(json |> member "matchtype_id" |> to_int)
  ; matchmembers = Yojson.Basic.Util.(json |> member "matchmembers" |> to_list |> List.map Match_member.from_json)
  ; observernum = Yojson.Basic.Util.(json |> member "observernum" |> to_int)
  ; observermax = Yojson.Basic.Util.(json |> member "observermax" |> to_int)
  ; isobservable = Yojson.Basic.Util.(json |> member "isobservable" |> to_int)
  ; observerdelay = Yojson.Basic.Util.(json |> member "observerdelay" |> to_int)
  ; hasobserverpassword = Yojson.Basic.Util.(json |> member "hasobserverpassword" |> to_int)
  ; servicetype = Yojson.Basic.Util.(json |> member "servicetype" |> to_int)
  ; relayserver_region = Yojson.Basic.Util.(json |> member "relayserver_region" |> to_string)
  }
;;
