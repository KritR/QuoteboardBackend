defmodule Quoteboard.Content do
  import Ecto.Query

  alias Quoteboard.{Repo, Content}

  def create_board(user, board) do
    Ecto.build_assoc(user, :boards)
    |> Content.Board.changeset(board)
    |> Repo.insert
  end

  def create_quote(user, board, quote) do
    Ecto.build_assoc(user, :quotes)
    |> Content.Quote.changeset(quote)
    |> Repo.preload(:boards)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:boards, [board])
    |> Repo.insert!
  end

  def find_board(id), do: Repo.get(Content.Board, id)

  def find_quote(id), do: Repo.get(Content.Quote, id)

  def list_boards do
    Repo.all(Content.Board)
  end

  def list_quotes do
    Repo.all(Content.Quote)
  end

  def update_board(id, board) do
    Repo.get!(Content.Board, id)
    |> Content.Board.changeset(board)
    |> Repo.update
  end

  def update_quote(id, quote) do
    Repo.get!(Content.Quote, id)
    |> Content.Quote.changeset(quote)
    |> Repo.update
  end

  def delete_board(id) do
    Repo.get!(Content.Board, id)
    |> Repo.delete
  end

  def delete_quote(id) do
    Repo.get!(Content.Quote, id)
    |> Repo.delete
  end

end
