type data_entry =
  { id1 : string
  ; id2 : string
  ; url : string
  ; icon : string
  ; name : string
  ; unknown1 : string
  ; unknown2 : string
  ; unknown3 : string
  ; unknown4 : string
  ; unknown5 : string option
  ; unknown6 : string option
  ; id3 : string
  ; id4 : string
  ; unknown7 : string list
  }

type config_entry =
  { key : string
  ; value : string
  }

type nested_entry =
  { id1 : string
  ; id2 : string
  ; url : string
  ; icon : string
  ; name : string
  ; clan : string
  ; score1 : string
  ; score2 : string
  ; score3 : string
  ; score4 : string
  ; score5 : string option
  ; id3 : string
  ; id4 : string
  ; unknown_list : string list
  }

type t =
  { id1 : string
  ; id2 : string
  ; timestamp1 : string
  ; timestamp2 : string
  ; data_entries : data_entry list
  ; unknown1 : string
  ; unknown2 : string
  ; unknown3 : string option
  ; config : config_entry list
  ; nested_entries : nested_entry list
  }

let from_json json =
  let open Yojson.Basic.Util in
  { id1 = json |> member "id1" |> to_string
  ; id2 = json |> member "id2" |> to_string
  ; timestamp1 = json |> member "timestamp1" |> to_string
  ; timestamp2 = json |> member "timestamp2" |> to_string
  ; data_entries =
      json
      |> member "data_entries"
      |> to_list
      |> List.map (fun entry ->
        { id1 = entry |> member "id1" |> to_string
        ; id2 = entry |> member "id2" |> to_string
        ; url = entry |> member "url" |> to_string
        ; icon = entry |> member "icon" |> to_string
        ; name = entry |> member "name" |> to_string
        ; unknown1 = entry |> member "unknown1" |> to_string
        ; unknown2 = entry |> member "unknown2" |> to_string
        ; unknown3 = entry |> member "unknown3" |> to_string
        ; unknown4 = entry |> member "unknown4" |> to_string
        ; unknown5 = entry |> member "unknown5" |> to_option to_string
        ; unknown6 = entry |> member "unknown6" |> to_option to_string
        ; id3 = entry |> member "id3" |> to_string
        ; id4 = entry |> member "id4" |> to_string
        ; unknown7 = entry |> member "unknown7" |> to_list |> List.map to_string
        })
  ; unknown1 = json |> member "unknown1" |> to_string
  ; unknown2 = json |> member "unknown2" |> to_string
  ; unknown3 = json |> member "unknown3" |> to_option to_string
  ; config =
      json
      |> member "config"
      |> to_list
      |> List.map (fun entry ->
        { key = entry |> member "key" |> to_string; value = entry |> member "value" |> to_string })
  ; nested_entries =
      json
      |> member "nested_entries"
      |> to_list
      |> List.map (fun entry ->
        { id1 = entry |> member "id1" |> to_string
        ; id2 = entry |> member "id2" |> to_string
        ; url = entry |> member "url" |> to_string
        ; icon = entry |> member "icon" |> to_string
        ; name = entry |> member "name" |> to_string
        ; clan = entry |> member "clan" |> to_string
        ; score1 = entry |> member "score1" |> to_string
        ; score2 = entry |> member "score2" |> to_string
        ; score3 = entry |> member "score3" |> to_string
        ; score4 = entry |> member "score4" |> to_string
        ; score5 = entry |> member "score5" |> to_option to_string
        ; id3 = entry |> member "id3" |> to_string
        ; id4 = entry |> member "id4" |> to_string
        ; unknown_list = entry |> member "unknown_list" |> to_list |> List.map to_string
        })
  }
;;

let to_json a =
  `Assoc
    [ "id1", `String a.id1
    ; "id2", `String a.id2
    ; "timestamp1", `String a.timestamp1
    ; "timestamp2", `String a.timestamp2
    ; ( "data_entries"
      , `List
          (List.map
             (fun entry ->
               `Assoc
                 [ "id1", `String entry.id1
                 ; "id2", `String entry.id2
                 ; "url", `String entry.url
                 ; "icon", `String entry.icon
                 ; "name", `String entry.name
                 ; "unknown1", `String entry.unknown1
                 ; "unknown2", `String entry.unknown2
                 ; "unknown3", `String entry.unknown3
                 ; "unknown4", `String entry.unknown4
                 ; ("unknown5", match entry.unknown5 with Some v -> `String v | None -> `Null)
                 ; ("unknown6", match entry.unknown6 with Some v -> `String v | None -> `Null)
                 ; "id3", `String entry.id3
                 ; "id4", `String entry.id4
                 ; "unknown7", `List (List.map (fun i -> `String i) entry.unknown7)
                 ])
             a.data_entries) )
    ; "unknown1", `String a.unknown1
    ; "unknown2", `String a.unknown2
    ; ("unknown3", match a.unknown3 with Some v -> `String v | None -> `Null)
    ; ( "config"
      , `List (List.map (fun entry -> `Assoc [ "key", `String entry.key; "value", `String entry.value ]) a.config) )
    ; ( "nested_entries"
      , `List
          (List.map
             (fun entry ->
               `Assoc
                 [ "id1", `String entry.id1
                 ; "id2", `String entry.id2
                 ; "url", `String entry.url
                 ; "icon", `String entry.icon
                 ; "name", `String entry.name
                 ; "clan", `String entry.clan
                 ; "score1", `String entry.score1
                 ; "score2", `String entry.score2
                 ; "score3", `String entry.score3
                 ; "score4", `String entry.score4
                 ; ("score5", match entry.score5 with Some v -> `String v | None -> `Null)
                 ; "id3", `String entry.id3
                 ; "id4", `String entry.id4
                 ; "unknown_list", `List (List.map (fun i -> `String i) entry.unknown_list)
                 ])
             a.nested_entries) )
    ]
;;
