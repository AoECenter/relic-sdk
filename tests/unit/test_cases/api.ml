open Lwt.Syntax
open Relic_sdk

let test_get_advertisements () =
  let* response = Util.request_with_file Api.Community.Advertisement.get "findAdvertisements.json" in
  match response with
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_news () =
  let* response = Util.request_with_file Api.Community.News.get "getNews.json" in
  match response with
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_available_achievements () =
  let* response = Util.request_with_file Api.Community.Achievement.get_available "getAvailableAchievements.json" in
  match response with
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_achievements () =
  let requester = Mock.Json_file.create_requester "getAchievements.json" in
  let* client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint = Api.Community.Achievement.get ~profile_ids:[ 1 ] in
  let* response = Client.get endpoint client ~requester in
  match response with
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_find_clans () =
  let requester = Mock.Json_file.create_requester "findClan.json" in
  let* client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint =
    Api.Community.Clan.find
      ~name:"My name"
      ~join_policies:[ Models.Stub.Community.Join_policy.Open ]
      ~tags:[ "My tag" ]
  in
  let* response = Client.get endpoint client ~requester in
  match response with
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_clan_info () =
  let requester = Mock.Json_file.create_requester "getClanInfoFull.json" in
  let* client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint = Api.Community.Clan.get "gli" in
  let* response = Client.get endpoint client ~requester in
  match response with
  | Some r -> Lwt.return @@ Alcotest.(check string) "Clan name was correct" "gli" r.clan.name
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_community_events () =
  let requester = Mock.Json_file.create_requester "getAvailableCommunityEvents.json" in
  let* client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint = Api.Community.Community_event.get in
  let* response = Client.get endpoint client ~requester in
  match response with
  | Some r ->
    Lwt.return
    @@ Alcotest.(check string)
         "Event name [0] was correct"
         "Season 7 - Solo Ranked - Controller"
         (List.nth r.communityEvents 0).name
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_leaderboards () =
  let requester = Mock.Json_file.create_requester "GetAvailableLeaderboards.json" in
  let* client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint = Api.Community.Leaderboard.get_available_leaderboards in
  let* response = Client.get endpoint client ~requester in
  match response with
  | Some r ->
    Lwt.return
    @@ Alcotest.(check string) "Event name [0] was correct" "SOLO_DM_RANKED" (List.nth r.leaderboards 0).name
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_avatar_stat () =
  let requester = Mock.Json_file.create_requester "GetAvatarStatForProfile.json" in
  let* client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint = Api.Community.Leaderboard.get_avatar ~profile_ids:[ 1 ] in
  let* response = Client.get endpoint client ~requester in
  match response with
  | Some r ->
    Lwt.return
    @@ Alcotest.(check int) "Profile id [0] was correct" 196240 (List.nth r.avatar_stats_for_profile 0).profile_id
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_leaderboard2 () =
  let requester = Mock.Json_file.create_requester "getLeaderBoard2.json" in
  let* client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint = Api.Community.Leaderboard.get_leaderboard_2 in
  let* response = Client.get endpoint client ~requester in
  match response with
  | Some r -> Lwt.return @@ Alcotest.(check int) "Id [0] was correct" 1178783 (List.nth r.stat_groups 0).id
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_inventory () =
  let requester = Mock.Json_file.create_requester "getInventoryByProfileIDs.json" in
  let* client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age4 in
  let endpoint = Api.Community.Item.get_inventory ~profile_ids:[ 1 ] in
  let* response = Client.get endpoint client ~requester in
  match response with
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_observable_advertisments () =
  let requester = Mock.Json_file.create_requester "findObservableAdvertisements.json" in
  let* client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age4 in
  let endpoint = Api.Game.Advertisement.find_observable in
  let* response = Client.get endpoint client ~requester in
  match response with
  | Some r -> Lwt.return @@ Alcotest.(check int) "Response was success" 0 r.status
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_proxy_request () =
  let requester = Mock.Json_file.create_requester "proxysteamuserrequest.json" in
  let* client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint =
    Api.Community.External.proxy_steam_request "/ISteamUser/GetPlayerSummaries/v0002/" [ "/steam/76561197984749679" ]
  in
  let* response = Client.get endpoint client ~requester in
  match response with
  | Some json ->
    (match json with
     | `Assoc items ->
       (match List.assoc_opt "result" items with
        | Some (`Assoc result_items) ->
          (match List.assoc_opt "message" result_items with
           | Some (`String msg) -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" msg
           | _ -> Lwt.fail_with "Unexpected JSON format: 'message' not found or wrong type")
        | _ -> Lwt.fail_with "Unexpected JSON format: 'result' not found or wrong type")
     | _ -> Lwt.fail_with "Unexpected JSON format: Top level is not an assoc")
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_invalid () =
  let endpoints = [ Api.Community.News.get ] in
  Lwt_list.iter_s (fun endpoint -> Util.request_with_file_throw endpoint) endpoints
;;
