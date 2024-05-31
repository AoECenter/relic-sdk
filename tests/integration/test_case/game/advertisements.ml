open Relic_sdk
open Test_state.Game
open Lwt.Syntax

let test_get_observable_advertisements test_state _ () =
  let open Data.Sort in
  let endpoint_asc = Api.Game.Advertisement.find_observable ~sort:Ascending ~count:2 in
  let endpoint_dsc = Api.Game.Advertisement.find_observable ~sort:Descending ~count:2 in
  let* lobbies_asc = Client.get endpoint_asc test_state.client in
  let* lobbies_dsc = Client.get endpoint_dsc test_state.client in
  match lobbies_asc, lobbies_dsc with
  | Some a, Some d ->
    let* _ = Lwt_io.printf "Yepge %d\n" (List.length a.advertisements) in
    let id_asc = (List.hd a.advertisements).match_id in
    let id_dsc = (List.hd d.advertisements).match_id in
    Alcotest.(check int) "Different match IDs" id_asc id_dsc;
    if id_asc = id_dsc
    then Lwt.fail_with "Expected different advertisement IDs in ascending and descending order"
    else Lwt.return_unit
  | _ -> Lwt.fail_with "No observable advertisements response"
;;
