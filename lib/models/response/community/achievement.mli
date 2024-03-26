(** Community achivement API response model

    Represents the response type for the
    [GET /community/achievement/getAchievements] endpoint *)

(** Raw reponse type, which corresponds to the model returned by the API endpoint *)
type t =
  { result : Stub.Response.t (** Result header containing result code and message *)
  ; achievement_defs : Stub.Achievement.t list (** List of achievement definitions *)
  }

(** [to_json r] converts an achivement defitnion response [r] into its JSON
    representation. *)
val to_json : t -> Yojson.Basic.t

(** [from_json j] converts a JSON representation of a raw API response [j]
    into its internal type. *)
val from_json : Yojson.Basic.t -> t
