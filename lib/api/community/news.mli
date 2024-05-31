(** Community news endpoints

    Represents all endpoints in [/community/news/*]
    - [GET /community/news/getNews]

    News are collections of text with an associated (optional) image.
    News items are valid only until their expirytime is exceeded.
    Although some news items have expired they may still be present
    in the response.*)

(** [get g d s] retrieves a list of currently available news in the
    game [g] on domain [d]. The request is sent with the method [s]. *)

val get : Data.Game.t -> string -> Data.Requester.Json.t -> Models.Response.Community.News.t option Lwt.t
