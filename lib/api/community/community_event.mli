(** Community event endpoints

    Represents all endpoints in [/community/CommunityEvent/*]
    - [GET /community/CommunityEvent/getAvailableCommunityEvents]

    (explain the concept of a community event here) *)

(** [get g d s] retrieves a list of currently available community events in the
    game [g] on domain [d]. The request is sent with the method [s]. *)

val get : Data.Game.t -> string -> Data.Requester.Json.t -> Models.Response.Community.Community_event.t option Lwt.t
