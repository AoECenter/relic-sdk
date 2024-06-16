let log ?m ?f level fmt =
  let ksprintf_logger str =
    let formatted_msg = Base.format_message ?m ?f level str in
    match level with Level.FATAL -> Lwt.fail_with formatted_msg | _ -> Lwt_io.printf "%s" formatted_msg
  in
  Printf.ksprintf ksprintf_logger fmt
;;

let debug ?m ?f fmt = log ?m ?f Level.DEBUG fmt
let info ?m ?f fmt = log ?m ?f Level.INFO fmt
let warn ?m ?f fmt = log ?m ?f Level.WARN fmt
let error ?m ?f fmt = log ?m ?f Level.ERROR fmt
let fatal ?m ?f fmt = log ?m ?f Level.FATAL fmt
