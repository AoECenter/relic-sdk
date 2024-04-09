open Lwt.Infix
open Relic_sdk

let test_get_advertisements () =
  Util.request_with_file Api.Community.Advertisement.get "findAdvertisements.json"
  >>= function
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_news () =
  Util.request_with_file Api.Community.News.get "getNews.json"
  >>= function
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_available_achievements () =
  Util.request_with_file Api.Community.Achievement.get_available "getAvailableAchievements.json"
  >>= function
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_achievements () =
  let requester = Mock.Json_file.create_requester "getAchievements.json" in
  let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint = Api.Community.Achievement.get ~profile_ids:[ 1 ] in
  Client.get endpoint client ~requester
  >>= function
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_find_clans () =
  let requester = Mock.Json_file.create_requester "findClan.json" in
  let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint =
    Api.Community.Clan.find ~name:"My name" ~join_policies:[ Models.Stub.Join_policy.Open ] ~tags:[ "My tag" ]
  in
  Client.get endpoint client ~requester
  >>= function
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_clan_info () =
  let requester = Mock.Json_file.create_requester "getClanInfoFull.json" in
  let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint = Api.Community.Clan.get "gli" in
  Client.get endpoint client ~requester
  >>= function
  | Some r -> Lwt.return @@ Alcotest.(check string) "Clan name was correct" "gli" r.clan.name
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_community_events () =
  let requester = Mock.Json_file.create_requester "getAvailableCommunityEvents.json" in
  let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint = Api.Community.Community_event.get in
  Client.get endpoint client ~requester
  >>= function
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
  let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint = Api.Community.Leaderboard.get in
  Client.get endpoint client ~requester
  >>= function
  | Some r ->
    Lwt.return
    @@ Alcotest.(check string) "Event name [0] was correct" "SOLO_DM_RANKED" (List.nth r.leaderboards 0).name
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_avatar_stat () =
  let requester = Mock.Json_file.create_requester "GetAvatarStatForProfile.json" in
  let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint = Api.Community.Leaderboard.get_avatar ~profile_ids:[ 1 ] in
  Client.get endpoint client ~requester
  >>= function
  | Some r ->
    Lwt.return
    @@ Alcotest.(check int) "Profile id [0] was correct" 196240 (List.nth r.avatar_stats_for_profile 0).profile_id
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_leaderboard2 () =
  let requester = Mock.Json_file.create_requester "getLeaderBoard2.json" in
  let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  let endpoint = Api.Community.Leaderboard.get_leaderboard_2 in
  Client.get endpoint client ~requester
  >>= function
  | Some r -> Lwt.return @@ Alcotest.(check int) "Id [0] was correct" 1178783 (List.nth r.stat_groups 0).id
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_invalid () =
  let endpoints = [ Api.Community.News.get ] in
  Lwt_list.iter_s (fun endpoint -> Util.request_with_file_throw endpoint) endpoints
;;
