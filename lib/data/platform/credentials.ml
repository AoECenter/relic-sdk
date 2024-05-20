type t =
  { account_type : Platform_type.t
  ; active_match_id : string
  ; alias : string
  ; app_id : int
  ; auth : string
  ; call_num : int
  ; client_lib_version : int
  ; connect_id : string
  ; country : string
  ; installation_type : string
  ; language : string
  ; mac_address : string
  ; major_version : string
  ; minor_version : string
  ; platform_environment : string
  ; platform_user_id : string
  ; start_game_token : string
  ; store_license_token : string
  ; store_token : string
  ; sync_hash : string
  ; timeout_override : int
  ; game : Game.t
  }
