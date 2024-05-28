type t =
  { result : Stub.Community.Response.t
  ; news : Stub.Community.News.t list
  }

let to_json r =
  `Assoc
    [ "result", Stub.Community.Response.to_json r.result
    ; "news", `List (List.map Stub.Community.News.to_json r.news)
    ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = json |> member "result" |> Stub.Community.Response.from_json
  ; news = json |> member "news" |> to_list |> List.map Stub.Community.News.from_json
  }
;;
