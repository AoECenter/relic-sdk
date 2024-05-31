open Lwt.Syntax
open Data.Sort

let find_observable ?(start = 1) ?(count = 100) ?(sort = Descending) ?(profile_ids = []) game domain send =
  let should_descend = match sort with Ascending -> 0 | Descending -> 1 in
  let base_url = Uri.make ~scheme:"https" ~host:domain ~path:"/game/advertisement/findObservableAdvertisements" () in
  let url =
    Uri.with_query'
      base_url
      [ "title", Data.Game.to_str game
      ; "start", string_of_int start
      ; "count", string_of_int count
      ; "desc", string_of_int should_descend
      ; "sortOrder", string_of_int should_descend
      ; "dataChecksum", "0"
      ; "modDLLFile", "INVALID"
      ; "modName", "INVALID"
      ; "modVersion", "INVALID"
      ; "modDLLChecksum", "0"
      ; "dataChecksum", "-888"
      ; "appBinaryChecksum", "113358"
      ; "versionFlags", "56950784"
      ; "profileids", Data.Query.encode_lst_i profile_ids
      ]
  in
  let* json = send url in
  match json with
  | Some j ->
    Lwt.return
    @@ Data.Json.try_parse_as
         (module Models.Response.Game.Observable_advertisements : Data.Json.JsonParsable
           with type t = Models.Response.Game.Observable_advertisements.t)
         j
  | None -> Lwt.return None
;;
