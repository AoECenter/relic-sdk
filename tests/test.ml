let () =
  Lwt_main.run
  @@ Alcotest_lwt.run
       "Relic SDK"
       [ ( "api"
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
           ; Alcotest_lwt.test_case "invalid json" `Quick (fun _ () -> Test_cases.Api.test_invalid ())
           ] )
       ; ( "query"
         , [ Alcotest_lwt.test_case "encode list<int>" `Quick (fun _ () -> Test_cases.Query.test_encode_list_int ())
           ; Alcotest_lwt.test_case "encode list<float>" `Quick (fun _ () ->
               Test_cases.Query.test_encode_list_float ())
           ; Alcotest_lwt.test_case "encode list<string>" `Quick (fun _ () ->
               Test_cases.Query.test_encode_list_string ())
           ] )
       ]
;;
