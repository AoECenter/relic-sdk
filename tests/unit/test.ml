let () =
  Lwt_main.run
  @@ Alcotest_lwt.run
       "Relic SDK"
       [ ( "Community API"
         , [ Alcotest_lwt.test_case "/community/advertisement/findAdvertisements" `Quick (fun _ () ->
               Test_cases.Api.test_get_advertisements ())
           ; Alcotest_lwt.test_case "/community/news/getNews" `Quick (fun _ () -> Test_cases.Api.test_get_news ())
           ; Alcotest_lwt.test_case "/community/achievement/getAchievements" `Quick (fun _ () ->
               Test_cases.Api.test_get_achievements ())
           ; Alcotest_lwt.test_case "/community/achievement/getAvailableAchievements" `Quick (fun _ () ->
               Test_cases.Api.test_get_available_achievements ())
           ; Alcotest_lwt.test_case "/community/clan/find" `Quick (fun _ () -> Test_cases.Api.test_find_clans ())
           ; Alcotest_lwt.test_case "/community/clan/getClanInfoFull" `Quick (fun _ () ->
               Test_cases.Api.test_get_clan_info ())
           ; Alcotest_lwt.test_case "/community/CommunityEvent/getAvailableCommunityEvents" `Quick (fun _ () ->
               Test_cases.Api.test_get_community_events ())
           ; Alcotest_lwt.test_case "/community/leaderboard/GetAvailableLeaderboards" `Quick (fun _ () ->
               Test_cases.Api.test_get_leaderboards ())
           ; Alcotest_lwt.test_case "/community/leaderboard/GetAvatarStatForProfile" `Quick (fun _ () ->
               Test_cases.Api.test_get_avatar_stat ())
           ; Alcotest_lwt.test_case "/community/leaderboard/getLeaderBoard2" `Quick (fun _ () ->
               Test_cases.Api.test_get_leaderboard2 ())
           ; Alcotest_lwt.test_case "/community/leaderboard/getInventoryByProfileIDs" `Quick (fun _ () ->
               Test_cases.Api.test_get_inventory ())
           ; Alcotest_lwt.test_case "/community/external/proxysteamuserrequest" `Quick (fun _ () ->
               Test_cases.Api.test_proxy_request ())
           ; Alcotest_lwt.test_case "invalid json" `Quick (fun _ () -> Test_cases.Api.test_invalid ())
           ] )
       ]
;;
