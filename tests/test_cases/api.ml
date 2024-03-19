open Lwt.Infix
open Relic_sdk

let test_get_advertisements () =
  Util.request_with_file Api.Community.Advertisement.get "findAdvertisements.json"
  >>= Assert.Lwt_impl.assert_not_none
  >>= fun response -> Lwt.return response.result.message >>= Assert.Lwt_impl.assert_message_success
;;

let test_get_news () =
  Util.request_with_file Api.Community.News.get "getNews.json"
  >>= Assert.Lwt_impl.assert_not_none
  >>= fun response -> Lwt.return response.result.message >>= Assert.Lwt_impl.assert_message_success
;;

let test_get_available_achievements () =
  Util.request_with_file Api.Community.Achievement.get_available "getAvailableAchievements.json"
  >>= Assert.Lwt_impl.assert_not_none
  >>= fun response -> Lwt.return response.result.message >>= Assert.Lwt_impl.assert_message_success
;;
