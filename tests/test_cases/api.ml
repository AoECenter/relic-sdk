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
  Client.get (Api.Community.Achievement.get ~profile_ids:[ 1 ]) client ~requester
  >>= function
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_find_clans () =
  let requester = Mock.Json_file.create_requester "findClan.json" in
  let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  Client.get
    (Api.Community.Clan.find ~name:"My name" ~join_policies:[ Models.Stub.Join_policy.Open ] ~tags:[ "My tag" ])
    client
    ~requester
  >>= function
  | Some r -> Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" r.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_clan_info () =
  let requester = Mock.Json_file.create_requester "getClanInfoFull.json" in
  let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  Client.get (Api.Community.Clan.get "gli") client ~requester
  >>= function
  | Some r -> Lwt.return @@ Alcotest.(check string) "Clan name was correct" "gli" r.clan.name
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_get_community_events () =
  let requester = Mock.Json_file.create_requester "getAvailableCommunityEvents.json" in
  let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  Client.get Api.Community.Community_event.get client ~requester
  >>= function
  | Some r ->
    Lwt.return
    @@ Alcotest.(check string)
         "Event name [0] was correct"
         "Season 7 - Solo Ranked - Controller"
         (List.nth r.communityEvents 0).name
  | None -> Lwt.fail_with "Expected Some but got None"
;;

let test_invalid () =
  let endpoints = [ Api.Community.News.get ] in
  Lwt_list.iter_s (fun endpoint -> Util.request_with_file_throw endpoint) endpoints
;;
