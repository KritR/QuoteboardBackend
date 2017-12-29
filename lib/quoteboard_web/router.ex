defmodule QuoteboardWeb.Router do
  use QuoteboardWeb, :router

  pipeline :graphql do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug QuoteboardWeb.Context
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :graphql

    forward "/", Absinthe.Plug,
      schema: QuoteboardWeb.Schema
  end

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: QuoteboardWeb.Schema

end
