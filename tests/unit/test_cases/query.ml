open Relic_sdk

let test_encode_list_int () =
  let lst = [ 1; 5; 7 ] in
  let encoded = Data.Query.encode_lst_i lst in
  Lwt.return @@ Alcotest.(check string) "List was encoded" "[1,5,7]" encoded
;;

let test_encode_list_float () =
  let lst = [ 1.2; 5.3; 7.7 ] in
  let encoded = Data.Query.encode_lst_f lst in
  Lwt.return @@ Alcotest.(check string) "List was encoded" "[1.2,5.3,7.7]" encoded
;;

let test_encode_list_string () =
  let lst = [ "item1"; "item2"; "item3"; "&"; "?" ] in
  let encoded = Data.Query.encode_lst_s lst in
  Lwt.return @@ Alcotest.(check string) "List was encoded" "[\"item1\",\"item2\",\"item3\",\"&\",\"?\"]" encoded
;;
