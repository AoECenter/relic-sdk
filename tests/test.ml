let () =
  Lwt_main.run
  @@ Alcotest_lwt.run
       "Relic SDK"
       [ ( "api"
         , [ Alcotest_lwt.test_case "get advertisements" `Quick (fun _ () ->
               Test_cases.Api.test_get_advertisements ())
           ; Alcotest_lwt.test_case "get news" `Quick (fun _ () -> Test_cases.Api.test_get_news ())
           ; Alcotest_lwt.test_case "get achievements" `Quick (fun _ () -> Test_cases.Api.test_get_achievements ())
           ; Alcotest_lwt.test_case "get available achievements" `Quick (fun _ () ->
               Test_cases.Api.test_get_available_achievements ())
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
