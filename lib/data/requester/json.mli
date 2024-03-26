(** JSON endpoint request function signature *)

(** Represents a function, which takes a URI and returns a JSON representation
    of it's value when requested. *)
type t = Uri.t -> Yojson.Basic.t option Lwt.t
