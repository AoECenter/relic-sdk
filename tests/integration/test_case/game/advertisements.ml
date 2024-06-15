open Relic_sdk
open Test_state.Game
open Lwt.Syntax

let test_get_observable_advertisements test_state _ () =
  let open Data.Sort in
  let endpoint = Api.Game.Advertisement.find_observable ~sort:Ascending ~count:1 in
  let* lobbies = Client.get endpoint test_state.client in
  match lobbies with
  | Some l when List.length l.members > 0 && List.length l.advertisements > 0 -> Lwt.return_unit
  | Some _ -> Lwt.fail_with "No members or advertisements found in the observable advertisements"
  | None -> Lwt.fail_with "No observable advertisements response"
;;
