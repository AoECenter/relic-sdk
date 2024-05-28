type t =
  { id : int
  ; entityversion : int
  ; itemdefinition_id : int
  ; profile_id : int
  ; durability : int
  ; durabilitytype : int
  ; metadata : string
  ; creationdate : int
  ; itemlocation_locationid : int
  ; itemtrade_id : int
  ; permissionflags : int
  ; maxchargesperitem : int
  }

let to_json i =
  `Assoc
    [ "id", `Int i.id
    ; "entityversion", `Int i.entityversion
    ; "itemdefinition_id", `Int i.itemdefinition_id
    ; "profile_id", `Int i.profile_id
    ; "durability", `Int i.durability
    ; "durabilitytype", `Int i.durabilitytype
    ; "metadata", `String i.metadata
    ; "creationdate", `Int i.creationdate
    ; "itemlocation_locationid", `Int i.itemlocation_locationid
    ; "itemtrade_id", `Int i.itemtrade_id
    ; "permissionflags", `Int i.permissionflags
    ; "maxchargesperitem", `Int i.maxchargesperitem
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { id = json |> member "id" |> to_int
  ; entityversion = json |> member "entityversion" |> to_int
  ; itemdefinition_id = json |> member "itemdefinition_id" |> to_int
  ; profile_id = json |> member "profile_id" |> to_int
  ; durability = json |> member "durability" |> to_int
  ; durabilitytype = json |> member "durabilitytype" |> to_int
  ; metadata = json |> member "metadata" |> to_string
  ; creationdate = json |> member "creationdate" |> to_int
  ; itemlocation_locationid = json |> member "itemlocation_locationid" |> to_int
  ; itemtrade_id = json |> member "itemtrade_id" |> to_int
  ; permissionflags = json |> member "permissionflags" |> to_int
  ; maxchargesperitem = json |> member "maxchargesperitem" |> to_int
  }
;;
