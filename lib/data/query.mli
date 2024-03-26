(** Useful query parameter transformation utility functions. *)

(** [encode_lst_i l] encodes a list of integers [l] into a string safe for the relic-link API.
    {[
      let () =
        let open Relic_sdk.Data in
        let query_safe_list = Query.encode_lst_i [ 1; 2 ] in
        query_safe_list
      ;;
      (* Results in "%5B1,2%5D" *)
    ]} *)
val encode_lst_i : int list -> string

(** [encode_lst_f l] encodes a list of floats [l] into a string safe for the relic-link API.
    {[
      let () =
        let open Relic_sdk.Data in
        let query_safe_list = Query.encode_lst_f [ 1.1; 2.2 ] in
        query_safe_list
      ;;
      (* Results in "%5B1.1,2.2%5D" *)
    ]} *)
val encode_lst_f : float list -> string

(** [encode_lst_s l] encodes a list of strings [l] into a string safe for the relic-link API.
    {[
      let () =
        let open Relic_sdk.Data in
        let query_safe_list = Query.encode_lst_s [ "a"; "?" ] in
        query_safe_list
      ;;
      (* Results in "%5B%22a%22,%22%3F%22%5D" *)
    ]} *)
val encode_lst_s : string list -> string

(** An example of the usage of these utility functions can be found in {!val:Relic_sdk.Api.Community.Achievement.get}. *)
