(* The interpreted values are just assumed - I don't know where this information is. *)
type t =
  | Open
  | InviteOnly
  | Closed

let from_int i =
  match i with
  | 0 -> Open
  | 1 -> InviteOnly
  | 2 -> Closed
  | _ -> failwith (Printf.sprintf "Invalid join policy integer: %d" i)
;;

let to_int = function Open -> 0 | InviteOnly -> 1 | Closed -> 2
