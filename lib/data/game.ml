[@@@warning "-37"]

type t =
  | Age1
  | Age2
  | Age3
  | Age4

let to_str = function Age1 -> "age1" | Age2 -> "age2" | Age3 -> "age3" | Age4 -> "age4"
