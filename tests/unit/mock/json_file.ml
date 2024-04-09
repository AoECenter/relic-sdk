let create_requester filename =
  let path = "res/" ^ filename in
  fun _ -> Lwt.return @@ Some (Yojson.Basic.from_file path)
;;
