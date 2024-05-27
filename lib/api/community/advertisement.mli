(** Community advertisement endpoints

    Represents all endpoints in [/community/advertisement/*]
    - [GET /community/advertisement/findAdvertisements]

    "Advertisements" is the name for lobby entries in the ranked ladder, quick play and custom lobby browser. *)

(** [get s c g d s] retrieves a paginated list of currently open lobbies in the
    game [g] on domain [d] in range [s] to [s] + [c]. The request is sent with
    the method [s]. Be aware that [c] is {b not allowed to exceed 100} *)
val get
  :  ?start:int
  -> ?count:int
  -> Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Models.Response.Community.Advertisement.t option Lwt.t
