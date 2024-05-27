type t =
  { rank : int
  ; chat : bool
  ; promote : bool
  ; demote : bool
  ; invite : bool
  ; remove : bool
  ; disband : bool
  ; editinfo : bool
  ; editpermission : bool
  ; name : string
  ; locstringid : int
  }

let to_json c =
  `Assoc
    [ "rank", `Int c.rank
    ; "chat", `Int (if c.chat then 1 else 0)
    ; "promote", `Int (if c.promote then 1 else 0)
    ; "demote", `Int (if c.demote then 1 else 0)
    ; "invite", `Int (if c.invite then 1 else 0)
    ; "remove", `Int (if c.remove then 1 else 0)
    ; "disband", `Int (if c.disband then 1 else 0)
    ; "editinfo", `Int (if c.editinfo then 1 else 0)
    ; "editpermission", `Int (if c.editpermission then 1 else 0)
    ; "name", `String c.name
    ; "locstringid", `Int c.locstringid
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { rank = json |> member "rank" |> to_int
  ; chat = json |> member "chat" |> to_int == 1
  ; promote = json |> member "promote" |> to_int == 1
  ; demote = json |> member "demote" |> to_int == 1
  ; invite = json |> member "invite" |> to_int == 1
  ; remove = json |> member "remove" |> to_int == 1
  ; disband = json |> member "disband" |> to_int == 1
  ; editinfo = json |> member "editinfo" |> to_int == 1
  ; editpermission = json |> member "editpermission" |> to_int == 1
  ; name = json |> member "name" |> to_string
  ; locstringid = json |> member "locstringid" |> to_int
  }
;;
