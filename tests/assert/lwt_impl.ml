let assert_not_none option =
  match option with Some o -> Lwt.return o | None -> Lwt.fail_with "Expected Some but got None"
;;

let assert_message_success message = Lwt.return @@ Alcotest.(check string) "Response was success" "SUCCESS" message
