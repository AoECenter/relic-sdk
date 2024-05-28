type t =
  { id : int
  ; name : string
  ; fullname : string
  ; description : string
  ; tags : string
  ; icon : string
  ; membercount : int
  ; joinpolicy : Join_policy.t
  ; metadata : string
  ; messageoftheday : string
  ; statgroup_id : int
  ; permissions : Clan_permissions.t list
  }

let to_json c =
  `Assoc
    [ "id", `Int c.id
    ; "name", `String c.name
    ; "fullname", `String c.fullname
    ; "description", `String c.description
    ; "tags", `String c.tags
    ; "icon", `String c.icon
    ; "membercount", `Int c.membercount
    ; "joinpolicy", `Int (Join_policy.to_int c.joinpolicy)
    ; "metadata", `String c.metadata
    ; "messageoftheday", `String c.messageoftheday
    ; "statgroup_id", `Int c.statgroup_id
    ; "permissions", `List (List.map Clan_permissions.to_json c.permissions)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { id = json |> member "id" |> to_int
  ; name = json |> member "name" |> to_string
  ; fullname = json |> member "fullname" |> to_string
  ; description = json |> member "description" |> to_string
  ; tags = json |> member "tags" |> to_string
  ; icon = json |> member "icon" |> to_string
  ; membercount = json |> member "membercount" |> to_int
  ; joinpolicy = (Join_policy.from_int @@ Yojson.Basic.Util.(json |> member "joinpolicy" |> to_int))
  ; metadata = json |> member "metadata" |> to_string
  ; messageoftheday = json |> member "messageoftheday" |> to_string
  ; statgroup_id = json |> member "statgroup_id" |> to_int
  ; permissions = Yojson.Basic.Util.(json |> member "permissions" |> to_list |> List.map Clan_permissions.from_json)
  }
;;
