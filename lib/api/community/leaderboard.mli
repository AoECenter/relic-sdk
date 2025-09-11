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

(** [get_leaderboard_2 l g d s] retrieves the leaderboard with id [l]
    for game [g] on domain [d]. Requests are sent with [s].
    Start must be in the range(1, 2147483647). Count must be in the range(1, 200). *)
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

(** [get_recent_match_history p g d s] retrieves recent matches for the provided profile_ids [p]
    for game [g] on domain [d]. Requests are sent with [s]. At most 10 profile_ids may be given. *)
val get_recent_match_history
  :  profile_ids:int list
  -> Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Models.Response.Community.Recent_match_history.t option Lwt.t

(** [get_personal_stat p g d s] retrieves personal stats for the provided profile_ids [p]
    for game [g] on domain [d]. Requests are sent with [s]. At most 10 profile_ids may be given. *)
val get_personal_stat
  :  profile_ids:int list
  -> Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Models.Response.Community.Personal_stat.t option Lwt.t
