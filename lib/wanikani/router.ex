defmodule WaniKani.Router do
  use Plug.Router

  #  plug(Plug.Logger)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason
  )

  forward("/api",
    to: Absinthe.Plug,
    init_opts: [schema: WaniKani.Schema]
  )

  forward("/graphiql",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [schema: WaniKani.Schema]
  )

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
