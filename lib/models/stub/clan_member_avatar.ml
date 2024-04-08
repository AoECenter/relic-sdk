type t =
  { entityversion : int
  ; profile_id : int
  ; name : string
  ; metadata : string
  ; alias : string
  ; clanlist_name : string
  ; personal_statgroup_id : int
  ; xp : int
  ; level : int
  ; leaderboardregion_id : int
  ; presence_id : int
  ; presenceproperty : string list (* This type is an assumption, it could be any list for all I know *)
  }

let to_json a =
  `Assoc
    [ "entityversion", `Int a.entityversion
    ; "profile_id", `Int a.profile_id
    ; "name", `String a.name
    ; "metadata", `String a.metadata
    ; "alias", `String a.alias
    ; "clanlist_name", `String a.clanlist_name
    ; "personal_statgroup_id", `Int a.personal_statgroup_id
    ; "xp", `Int a.xp
    ; "level", `Int a.level
    ; "leaderboardregion_id", `Int a.leaderboardregion_id
    ; "presence_id", `Int a.presence_id
    ; "presenceproperty", `List (List.map (fun p -> `String p) a.presenceproperty)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { entityversion = json |> member "entityversion" |> to_int
  ; profile_id = json |> member "profile_id" |> to_int
  ; name = json |> member "name" |> to_string
  ; metadata = json |> member "metadata" |> to_string
  ; alias = json |> member "alias" |> to_string
  ; clanlist_name = json |> member "clanlist_name" |> to_string
  ; personal_statgroup_id = json |> member "personal_statgroup_id" |> to_int
  ; xp = json |> member "xp" |> to_int
  ; level = json |> member "level" |> to_int
  ; leaderboardregion_id = json |> member "leaderboardregion_id" |> to_int
  ; presence_id = json |> member "presence_id" |> to_int
  ; presenceproperty = json |> member "presenceproperty" |> to_list |> List.map to_string
  }
;;
