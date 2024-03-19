type news_entry =
  { id : int
  ; hidden : int
  ; newscategory : string
  ; newstitle_locstringid : int
  ; newssubtitle_locstringid : int
  ; newstext_locstringid : int
  ; newsimage : string
  ; newsbody : string
  ; metadata : string
  ; datevisible : int
  ; expirytime : int
  }

let to_json e =
  `Assoc
    [ "id", `Int e.id
    ; "hidden", `Int e.hidden
    ; "newscategory", `String e.newscategory
    ; "newstitle_locstringid", `Int e.newstitle_locstringid
    ; "newssubtitle_locstringid", `Int e.newssubtitle_locstringid
    ; "newstext_locstringid", `Int e.newstext_locstringid
    ; "newsimage", `String e.newsimage
    ; "newsbody", `String e.newsbody
    ; "metadata", `String e.metadata
    ; "datevisible", `Int e.datevisible
    ; "expirytime", `Int e.expirytime
    ]
;;

let from_json json =
  { id = Yojson.Basic.Util.(json |> member "id" |> to_int)
  ; hidden = Yojson.Basic.Util.(json |> member "hidden" |> to_int)
  ; newscategory = Yojson.Basic.Util.(json |> member "newscategory" |> to_string)
  ; newstitle_locstringid = Yojson.Basic.Util.(json |> member "newstitle_locstringid" |> to_int)
  ; newssubtitle_locstringid = Yojson.Basic.Util.(json |> member "newssubtitle_locstringid" |> to_int)
  ; newstext_locstringid = Yojson.Basic.Util.(json |> member "newstext_locstringid" |> to_int)
  ; newsimage = Yojson.Basic.Util.(json |> member "newsimage" |> to_string)
  ; newsbody = Yojson.Basic.Util.(json |> member "newsbody" |> to_string)
  ; metadata = Yojson.Basic.Util.(json |> member "metadata" |> to_string)
  ; datevisible = Yojson.Basic.Util.(json |> member "datevisible" |> to_int)
  ; expirytime = Yojson.Basic.Util.(json |> member "expirytime" |> to_int)
  }
;;
