(** Community achievement endpoints

    Represents all endpoints in [/community/achievement/*]
    - [GET /community/achievement/getAchievements]
    - [GET /community/achievement/getAvailableAchievements]

    Achivements are rewards that are triggered conditionally when playing
    the game and additonal details can be viewed on
    {{:https://steamcommunity.com/stats/813780/achievements} the steam
    community achievement page}. *)

(** [get_available g d s] retrieves all available achievements for game [g]
    on domain [d] sending the request with [s]. Information about the attainment
    state of achievmenets for a specific user is available in {!get}

    Example usage:

    {[
      open Lwt.Syntax
      open Relic_sdk

      let get_number_of_achievements =
        let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
        let* achievements = Client.get Api.Community.Achievement.get_available client in
        match achievements with Some a -> Lwt.return @@ List.length a.achievement_defs | None -> Lwt.return 0
      ;;
    ]} *)
val get_available
  :  Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Models.Response.Community.Achievement.t option Lwt.t

(** [get i g d s] retrieves the achievement attainment state for every user id
    in [i] for game [g] on domain [d]. Requests are sent with [s].

    Example usage:

    {[
      open Lwt.Syntax
      open Relic_sdk

      let user_attained_achievement (profile_id : int) (achievement_id : int) =
        let client = Client.create "aoe-api.worldsedgelink.com" Data.Game.Age2 in
        let* a_attainment = Client.get Api.Community.Achievement.get ~profile_ids:[ profile_id ] client in
        match a_attainment with
        | None -> false
        | Some attainment ->
          Lwt.return
          @@ List.exists
               (fun a -> a.achievement_id = achievement_id)
               attainment.user_achievement_map.(string_of_int profile_id)
      ;;
    ]} *)
val get
  :  ?profile_ids:int list
  -> Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Models.Response.Community.Achievement_attainment.t option Lwt.t
