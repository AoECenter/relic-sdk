let get_timestamp () =
  let open Unix in
  let tm = localtime (time ()) in
  Printf.sprintf
    "%04d-%02d-%02d %02d:%02d:%02d"
    (tm.tm_year + 1900)
    (tm.tm_mon + 1)
    tm.tm_mday
    tm.tm_hour
    tm.tm_min
    tm.tm_sec
;;

let format_message ?(m = "") ?(f = "") level msg =
  let time_str = get_timestamp () in
  let level_str = Level.to_string level in
  let color = Level.to_color level in
  let reset = Level.reset_color in
  let location_str =
    match m, f with
    | "", "" -> ""
    | "", f -> Printf.sprintf "[%s]" f
    | m, "" -> Printf.sprintf "[%s]" m
    | m, f -> Printf.sprintf "[%s::%s]" m f
  in
  Printf.sprintf "[%s] [%s%s%s] %s %s\n%!" time_str color level_str reset location_str msg
;;
