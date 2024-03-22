type achievement_response =
  { result : Stub.Response.header
  ; user_achievements_map : (string * Stub.Achievement_attainment.achievement_attainment) list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Response.to_json r.result
    ; ( "userAchievementsMap"
      , `List
          (List.map
             (fun (id, achievements) ->
               `Assoc [ id, `List (List.map Stub.Achievement_attainment.to_json achievements) ])
             r.user_achievements_map) )
    ]
;;

let from_json (json : Yojson.Basic.t) =
  { result = Yojson.Basic.Util.(json |> member "result" |> Stub.Response.from_json)
  ; user_achievements_map =
      Yojson.Basic.Util.(
        json
        |> member "userAchievementsMap"
        |> to_list
        |> List.fold_left
             (fun acc js ->
               match js with
               | `Assoc user_achievements ->
                 List.fold_left
                   (fun acc (id, ach_json) ->
                     match ach_json with
                     | `List achievements -> (id, List.map Stub.Achievement_attainment.from_json achievements) :: acc
                     | _ -> acc)
                   acc
                   user_achievements
               | _ -> acc)
             [])
  }
;;
