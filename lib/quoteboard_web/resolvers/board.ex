defmodule QuoteboardWeb.Resolvers.Board do
  def list_boards(_parent, _args, _resolution) do
    {:ok, Quoteboard.Content.list_boards()}
  end
end
