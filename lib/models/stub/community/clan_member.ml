type t =
  { avatar : Clan_member_avatar.t
  ; membershipstatus : int
  ; playerlistpermission_rank : int
  }

let clan_member_to_json m =
  `Assoc
    [ "avatar", Clan_member_avatar.to_json m.avatar
    ; "membershipstatus", `Int m.membershipstatus
    ; "playerlistpermission_rank", `Int m.playerlistpermission_rank
    ]
;;

let clan_member_from_json json =
  let open Yojson.Basic.Util in
  { avatar = json |> member "avatar" |> Clan_member_avatar.from_json
  ; membershipstatus = json |> member "membershipstatus" |> to_int
  ; playerlistpermission_rank = json |> member "playerlistpermission_rank" |> to_int
  }
;;
