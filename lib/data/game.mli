(** Franchise version enum

    Relic-link API endpoints concern themselves with several version of the
    Age of Empires franchise. This is controlled through the use of a query
    parameter in requests. This variant represents the options for each
    version of the franchise. *)

type t =
  | Age1 (** Age of Empires 1: Definitive Edition *)
  | Age2 (** Age of Empires 2: Definitive Edition *)
  | Age3 (** Age of Empires 3: Definitive Edition *)
  | Age4 (** Age of Empires 4 *)
  | Coh3 (** Company of Heroes 3 *)
  | Dow1de (** Dawn of War: Definitive Edition *)

(** [to_str g] converts a game [g] into its string representation for use in the relic-link API *)
val to_str : t -> string

(** [to_str g] converts a game [g] into its steam app id *)
val to_app_id : t -> int
