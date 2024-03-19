open Lwt.Infix
open Relic_sdk

let request_with_file endpoint response_file =
  let requester = Mock.Json_file.create_requester response_file in
  let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  Client.get endpoint client ~requester
;;

let test_get_advertisements () =
  request_with_file Api.Community.Advertisement.get "findAdvertisements.json"
  >>= function
  | Some json -> Lwt.return @@ Alcotest.(check string) "Struct has id" "SUCCESS" json.result.message
  | None -> Lwt.fail_with "Expected Some but got None"
;;
