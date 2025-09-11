val get_available_leaderboards
  :  Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Models.Response.Community.Leaderboard.t option Lwt.t

val get : Data.Game.t -> string -> Data.Requester.Json.t -> Models.Response.Community.Leaderboard.t option Lwt.t
[@@deprecated "Use the more clearly named 'get_available_leaderboards' instead"]

val get_avatar
  :  ?profile_ids:int list
  -> Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Models.Response.Community.Avatar_stat.t option Lwt.t

val get_leaderboard_2
  :  ?sortby:Models.Stub.Community.Leaderboard_sorting.t
  -> ?platform:string
  -> ?leaderboard_id:int
  -> ?start:int
  -> ?count:int
  -> Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Models.Response.Community.Leaderboard2.t option Lwt.t

val get_recent_match_history
  :  profile_ids:int list
  -> Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Models.Response.Community.Recent_match_history.t option Lwt.t

val get_personal_stat
  :  profile_ids:int list
  -> Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Models.Response.Community.Personal_stat.t option Lwt.t
