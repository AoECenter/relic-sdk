(** [proxy_steam_request] is a function that builds a request to a remote
    Steam API proxy service. It constructs the URL with necessary parameters
    and utilizes a provided function to send the request and return the
    response as parsed JSON.

    @param steam_request_url The specific endpoint of the Steam API to be called.
    @param profile_names A list of profile names to be included in the request.
    @param game The specific game context for the request.
    @param domain The domain of the remote API service.
    @param send A function that takes a URI and returns a JSON response wrapped
                in an Lwt option monad.

    @return
      Returns a Yojson.Basic.t option wrapped in an Lwt monad, representing
      the parsed JSON response, or None if there's an error or no data. *)
val proxy_steam_request
  :  string
  -> string list
  -> Data.Game.t
  -> string
  -> Data.Requester.Json.t
  -> Yojson.Basic.t option Lwt.t
