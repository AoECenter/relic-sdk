type t =
  { result : Stub.Response.t
  ; user_achievements_map : (string * Stub.Achievement_attainment.t list) list
  }

let to_json r =
  let user_achievement_map_json =
    List.map
      (fun (user_id, achievements) ->
        `Assoc [ user_id, `List (List.map Stub.Achievement_attainment.to_json achievements) ])
      r.user_achievements_map
  in
  `Assoc [ "result", Stub.Response.to_json r.result; "userAchievementsMap", `List user_achievement_map_json ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  let result = Yojson.Basic.Util.(json |> member "result" |> Stub.Response.from_json) in
  let user_achievements_map =
    json
    |> member "userAchievementsMap"
    |> to_list
    |> List.fold_left
         (fun acc user_achievement_json ->
           match user_achievement_json with
           | `Assoc [ (user_id, `List achievements) ] ->
             (user_id, List.map Stub.Achievement_attainment.from_json achievements) :: acc
           | _ -> acc)
         []
  in
  { result; user_achievements_map }
;;
