defmodule QuoteboardWeb.Resolvers.Content do

  def create_board(_parent, args, _resolution) do
    Quoteboard.Content.create_board(args)
  end

  def create_quote(_parent, args, _resolution) do
    Quoteboard.Content.create_quote(args)
  end

  def list_boards(_parent, _args, _resolution) do
    {:ok, Quoteboard.Content.list_boards()}
  end

  def list_quotes(_parent, _args, _resolution) do
    {:ok, Quoteboard.Content.list_quotes()}
  end

  def update_board(_parent, %{id: id, board: board_params}, _resolution) do
    Quoteboard.Content.update_board(id, board_params)
  end

  def update_quote(_parent, %{id: id, quote: quote_params}, _resolution) do
    Quoteboard.Content.update_quote(id, quote_params)
  end

  def delete_board(_parent, %{id: id}, _resolution) do
    Quoteboard.Content.delete_board(id)
  end

  def delete_quote(_parent, %{id: id}, _resolution) do
    Quoteboard.Content.delete_quote(id)
  end

end
