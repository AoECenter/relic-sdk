module type JsonParsable = sig
  type t

  val from_json : Yojson.Basic.t -> t
end

let try_parse_as (type a) (module M : JsonParsable with type t = a) (j : Yojson.Basic.t) : a option =
  try Some (M.from_json j) with
  | Yojson.Basic.Util.Type_error (msg, _) ->
    Printf.printf "Json parsing error %s" msg;
    None
  | ex ->
    Logs.err (fun m -> m "Unexpected error: %s" (Printexc.to_string ex));
    None
;;
