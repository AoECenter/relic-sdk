open Relic_sdk
open Lwt.Infix
open Lwt.Syntax

let request_with_file endpoint response_file =
  let requester = Mock.Json_file.create_requester response_file in
  let* client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  Client.get endpoint client ~requester
;;

let request_with_file_throw endpoint =
  request_with_file endpoint "_empty.json"
  >>= function Some _ -> Lwt.fail_with "Expected None but got Some" | None -> Lwt.return_unit
;;
