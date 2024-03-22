open Relic_sdk

let request_with_file endpoint response_file =
  let requester = Mock.Json_file.create_requester response_file in
  let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
  Client.get endpoint client ~requester
;;
