type t =
  | Age1
  | Age2
  | Age3
  | Age4

let to_str = function Age1 -> "age1" | Age2 -> "age2" | Age3 -> "age3" | Age4 -> "age4"
let to_app_id = function Age1 -> 1017900 | Age2 -> 813780 | Age3 -> 933110 | Age4 -> 1466860
