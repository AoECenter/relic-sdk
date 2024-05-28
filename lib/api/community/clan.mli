(** Community clan endpoints

    Represents all endpoints in [/community/clan/*]
    - [GET /community/clan/find]
    - [GET /community/clan/getClanInfoFull] *)

(** [find n t j s c g d r] retrieves all clans that match [n], include tags
    within [t] and have a join policy included in [j] for the game [g] between index [s] and [s+c]. The request is sent with [r] on domain [d]. *)
val find
  :  ?name:string
  -> ?tags:string list
  -> ?join_policies:Models.Stub.Community.Join_policy.t list
  -> ?start:int
  -> ?count:int
  -> Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Models.Response.Community.Clan.t option Lwt.t

(** [get n g d s] retrieves all the available information for a clain in game [g] with name [n]. The reqeust is sent with [s] on domain [d]. *)
val get
  :  string
  -> Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Models.Response.Community.Clan_info.t option Lwt.t
