val get
  :  Data.Game.t
  -> string
  -> (Uri.t -> Yojson.Basic.t option Lwt.t)
  -> Models.Response.Community.News.t option Lwt.t
