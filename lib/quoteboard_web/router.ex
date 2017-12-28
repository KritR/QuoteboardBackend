defmodule QuoteboardWeb.Router do
  use QuoteboardWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: QuoteboardWeb.Schema

    forward "/", Absinthe.Plug,
      schema: QuoteboardWeb.Schema
  end
end
