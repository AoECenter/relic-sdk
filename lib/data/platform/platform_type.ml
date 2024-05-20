type t =
  | Steam
  | Xbox

let to_str = function Steam -> "STEAM" | Xbox -> "XBOX"
