defmodule QuoteboardWeb.Router do
  use QuoteboardWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", QuoteboardWeb do
    pipe_through :api
  end
end
