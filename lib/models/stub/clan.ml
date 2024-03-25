type t =
  { id : int
  ; name : string
  ; fullname : string
  ; description : string
  ; tags : string
  ; icon : string
  ; membercount : int
  ; joinpolicy : Join_policy.t
      (* TODO I have no idea what enum this could be - I'm guessing something like open vs invite only. It likely
         goes from 0-2 according to the sparse documentation *)
  ; metadata : string
  ; messageoftheday : string
  ; statgroup_id : int
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
    ]
;;

let from_json json =
  { id = Yojson.Basic.Util.(json |> member "id" |> to_int)
  ; name = Yojson.Basic.Util.(json |> member "name" |> to_string)
  ; fullname = Yojson.Basic.Util.(json |> member "fullname" |> to_string)
  ; description = Yojson.Basic.Util.(json |> member "description" |> to_string)
  ; tags = Yojson.Basic.Util.(json |> member "tags" |> to_string)
  ; icon = Yojson.Basic.Util.(json |> member "icon" |> to_string)
  ; membercount = Yojson.Basic.Util.(json |> member "membercount" |> to_int)
  ; joinpolicy = (Join_policy.from_int @@ Yojson.Basic.Util.(json |> member "joinpolicy" |> to_int))
  ; metadata = Yojson.Basic.Util.(json |> member "metadata" |> to_string)
  ; messageoftheday = Yojson.Basic.Util.(json |> member "messageoftheday" |> to_string)
  ; statgroup_id = Yojson.Basic.Util.(json |> member "statgroup_id" |> to_int)
  }
;;
