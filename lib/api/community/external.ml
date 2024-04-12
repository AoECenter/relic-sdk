let proxy_steam_request steam_request_url profile_names game domain send =
  match profile_names with
  | [] -> Lwt.fail_with "Profile names list cannot be empty"
  | _ids ->
    let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/community/external/proxysteamuserrequest" () in
    let url =
      Uri.with_query'
        base_url
        [ "title", Data.Game.to_str game
        ; "profile_names", Data.Query.encode_lst_s profile_names
        ; "request", steam_request_url
        ]
    in
    send url
;;
