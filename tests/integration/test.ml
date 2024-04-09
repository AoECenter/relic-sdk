open Relic_sdk
open Alcotest_lwt
open Lwt.Syntax

let setup_community () =
  let open Test_state.Community in
  let domain = "aoe-api.worldsedgelink.com" in
  let game = Data.Game.Age2 in
  let client = Client.create domain game in
  let endpoint = Api.Community.Leaderboard.get_leaderboard_2 ~count:1 in
  let* leaderboards_response = Client.get endpoint client in
  match leaderboards_response with
  | None -> Lwt.fail_with "No leaderboards response"
  | Some { stat_groups = []; _ } -> Lwt.fail_with "No stat groups"
  | Some { stat_groups = stat_group :: _; _ } ->
    (match stat_group.members with
     | [] -> Lwt.fail_with "No members"
     | test_member :: _ -> Lwt.return { client; test_member })
;;

let () =
  Lwt_main.run
  @@
  let* setup_data = setup_community () in
  let suite =
    [ ( "Community"
      , [ test_case
            "User achievement attainment"
            `Slow
            (Test_case.Community.Achievements.test_get_user_achievements setup_data)
        ; test_case
            "Non-user achievement attainment"
            `Slow
            (Test_case.Community.Achievements.test_get_user_achievements_no_user setup_data)
        ] )
    ]
  in
  Alcotest_lwt.run "Relic SDK" suite
;;
