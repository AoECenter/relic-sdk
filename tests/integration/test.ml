open Relic_sdk
open Alcotest_lwt
open Lwt.Syntax

let vgetenv k = try Sys.getenv k with Not_found -> failwith @@ Printf.sprintf "Environment variable %s not found" k

let setup_community () =
  let open Test_state.Community in
  let domain = "aoe-api.worldsedgelink.com" in
  let game = Data.Game.Age2 in
  let endpoint = Api.Community.Leaderboard.get_leaderboard_2 ~count:1 in
  let* client = Client.create domain game in
  let* leaderboards_response = Client.get endpoint client in
  match leaderboards_response with
  | None -> Lwt.fail_with "No leaderboards response"
  | Some { stat_groups = []; _ } -> Lwt.fail_with "No stat groups"
  | Some { stat_groups = stat_group :: _; _ } ->
    (match stat_group.members with
     | [] -> Lwt.fail_with "No members"
     | test_member :: _ -> Lwt.return { client; test_member })
;;

let setup_game () =
  let open Test_state.Game in
  let open Data.Platform.Steam_login in
  let login = Some { alias = vgetenv "STEAM_USER_ALIAS"; app_ticket = vgetenv "STEAM_APP_TICKET" } in
  let domain = "aoe-api.worldsedgelink.com" in
  let game = Data.Game.Age2 in
  let endpoint = Api.Community.Leaderboard.get_leaderboard_2 ~count:1 in
  let* client = Client.create ~login domain game in
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
  let* setup_data_community = setup_community () in
  let* setup_data_game = setup_game () in
  let suite =
    [ ( "Community"
      , [ test_case
            "User achievement attainment"
            `Slow
            (Test_case.Community.Achievements.test_get_user_achievements setup_data_community)
        ; test_case
            "Non-user achievement attainment"
            `Slow
            (Test_case.Community.Achievements.test_get_user_achievements_no_user setup_data_community)
        ] )
    ; ( "Game"
      , [ test_case
            "Advertisements"
            `Slow
            (Test_case.Game.Advertisements.test_get_observable_advertisements setup_data_game)
        ] )
    ]
  in
  Alcotest_lwt.run "Relic SDK" suite
;;
