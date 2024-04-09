open Relic_sdk
open Test_state.Community

let test_get_user_achievements test_state _ () =
  let open Lwt.Syntax in
  let endpoint = Api.Community.Achievement.get ~profile_ids:[ test_state.test_member.profile_id ] in
  let* attainment_opt = Client.get endpoint test_state.client in
  match attainment_opt with
  | Some attainment when not ([] == attainment.user_achievements_map) ->
    Lwt.return
      (Alcotest.check Alcotest.bool "Non-empty achievements map" true (not ([] == attainment.user_achievements_map)))
  | Some _ -> Lwt.fail_with "Achievement attainment response is empty"
  | None -> Lwt.fail_with "No achievement attainment response"
;;

let test_get_user_achievements_no_user test_state _ () =
  let open Lwt.Syntax in
  let endpoint = Api.Community.Achievement.get ~profile_ids:[ -2 ] in
  (* -1 is allowed in the API but -2 isn't *)
  let* attainment_opt = Client.get endpoint test_state.client in
  match attainment_opt with
  | Some _ -> Lwt.fail_with "Achievement attainment response exists (expected complete failure)"
  | None -> Lwt.return_unit
;;
