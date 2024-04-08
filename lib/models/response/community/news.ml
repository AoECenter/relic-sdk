type t =
  { result : Stub.Response.t
  ; news : Stub.News.t list
  }

let to_json r =
  `Assoc [ "result", Stub.Response.to_json r.result; "news", `List (List.map Stub.News.to_json r.news) ]
;;

let from_json json =
  let open Yojson.Basic.Util in
  { result = json |> member "result" |> Stub.Response.from_json
  ; news = json |> member "news" |> to_list |> List.map Stub.News.from_json
  }
;;
