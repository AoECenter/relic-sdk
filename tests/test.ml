let () =
  Lwt_main.run
  @@ Alcotest_lwt.run
       "API"
       [ "get", [ Alcotest_lwt.test_case "advertisements" `Quick (fun _ () -> Api.test_get_advertisements ()) ] ]
;;
