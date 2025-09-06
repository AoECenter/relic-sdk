type t =
  | Age1
  | Age2
  | Age3
  | Age4
  | Coh3
  | Dow1de

let to_str = function
  | Age1 -> "age1"
  | Age2 -> "age2"
  | Age3 -> "age3"
  | Age4 -> "age4"
  | Coh3 -> "coh3"
  | Dow1de -> "dow1-de"
;;

let to_app_id = function
  | Age1 -> 1017900
  | Age2 -> 813780
  | Age3 -> 933110
  | Age4 -> 1466860
  | Coh3 -> 1677280
  | Dow1de -> 3556750
;;

let to_domain = function
  | Age1 | Age2 | Age3 | Age4 -> "aoe-api.worldsedgelink.com"
  | Coh3 -> "coh3-api.reliclink.com"
  | Dow1de -> "dow-api.reliclink.com"
;;
