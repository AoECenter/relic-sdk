let () =
  let x =
    Relic_sdk.Compression.Domain.decompress_base64
      "eNrVkF1PwjAUhv0tvR6GMjYniTeDVWfcgLJ2gvGibl0o3QduEyHG/y6dgUiMF8YLs6uevufknCcP7GkPb2BdFolIuZsnxbmIwcCyTN0yLzVQ1awWRe6OwABqoOYsU2VXAwmLDo39r2QRP5a5vOMbnh5/HqujZbBbNxMdtUZkfMJLVLKMe7NmTlSYs3jXXFE3X6omznjNRqxmYABceWtjguwpQf1pGKvXCe6XNmkybM+6TW+MHQkDiUtPGuYsoGMiocqHFMkdzekidNav8xUaRjCdP11vV6y3haGMQ9/x8/2cjREyAoixT4znuZ5OKKJI5VO6uKHZUhBC1T7bE+4VeNe+u+vAE22dL97giTfVOYj7rP9krvuTud9S9lpBqbeCst8KSqMVlGYrKC/+ifLx7APyMc1P"
  in
  match x with
  | Some data -> Printf.printf "Decompressed data: %s\n" data
  | None ->
    Printf.printf "Decompression failed.\n";
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
             ; Alcotest_lwt.test_case "/community/CommunityEvent/getAvailableCommunityEvents" `Quick (fun _ () ->
                 Test_cases.Api.test_get_community_events ())
             ; Alcotest_lwt.test_case "/community/leaderboard/GetAvailableLeaderboards" `Quick (fun _ () ->
                 Test_cases.Api.test_get_leaderboards ())
             ; Alcotest_lwt.test_case "/community/leaderboard/GetAvatarStatForProfile" `Quick (fun _ () ->
                 Test_cases.Api.test_get_avatar_stat ())
             ; Alcotest_lwt.test_case "/community/leaderboard/getLeaderBoard2.json" `Quick (fun _ () ->
                 Test_cases.Api.test_get_leaderboard2 ())
             ; Alcotest_lwt.test_case "invalid json" `Quick (fun _ () -> Test_cases.Api.test_invalid ())
             ] )
         ]
;;
