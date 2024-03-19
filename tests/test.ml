let () =
  Lwt_main.run
  @@ Alcotest_lwt.run
       "API"
       [ ( "advertisements"
         , [ Alcotest_lwt.test_case "findAdvertisements" `Quick (fun _ () ->
               Test_cases.Api.test_get_advertisements ())
           ] )
       ; "news", [ Alcotest_lwt.test_case "getNews" `Quick (fun _ () -> Test_cases.Api.test_get_news ()) ]
       ; ( "achievements"
         , [ Alcotest_lwt.test_case "getAvailableAchievements" `Quick (fun _ () ->
               Test_cases.Api.test_get_available_achievements ())
           ] )
       ]
;;
