type t =
  { result : Stub.Response.t
  ; item_instances_by_profile_id : (string * Stub.Inventory.t list) list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Response.to_json r.result
    ; ( "itemInstancesByProfileID"
      , `List
          (List.map
             (fun (profile_id, items) -> `Assoc [ profile_id, `List (List.map Stub.Inventory.to_json items) ])
             r.item_instances_by_profile_id) )
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = json |> member "result" |> Stub.Response.from_json
  ; item_instances_by_profile_id =
      json
      |> member "itemInstancesByProfileID"
      |> to_list
      |> List.map (fun json ->
        match json with
        | `Assoc [ (profile_id, `List items) ] -> profile_id, List.map Stub.Inventory.from_json items
        | _ -> failwith "JSON structure mismatch")
  }
;;
