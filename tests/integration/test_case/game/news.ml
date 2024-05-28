open Relic_sdk
open Test_state.Game
open Lwt.Syntax

let test_get_news test_state _ () =
  let endpoint = Api.Game.News.get in
  let* news = Client.get endpoint test_state.client in
  match news with Some _ -> Lwt.return_unit | None -> Lwt.fail_with "No news response"
;;
