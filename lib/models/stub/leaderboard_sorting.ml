type t =
  | NumberOfWins
  | ByRating

let from_int i =
  match i with
  | 0 -> NumberOfWins
  | 1 -> ByRating
  | _ -> failwith (Printf.sprintf "Invalid join policy integer: %d" i)
;;

let to_int = function NumberOfWins -> 0 | ByRating -> 1
