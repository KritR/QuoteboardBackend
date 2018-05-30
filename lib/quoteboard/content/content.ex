defmodule Quoteboard.Content do
  import Ecto.Query

  alias Quoteboard.{Repo, Content}

  def create_board(user, board) do
    Ecto.build_assoc(user, :boards)
    |> Content.Board.changeset(board)
    |> Repo.insert()
  end

  def create_quote(user, board, qb_quote) do
    Ecto.build_assoc(user, :quotes)
    |> Content.Quote.changeset(qb_quote)
    |> Ecto.Changeset.put_assoc(:boards, [board])
    |> Repo.insert()
  end

  def find_board(id), do: Repo.get(Content.Board, id)

  def find_quote(id), do: Repo.get(Content.Quote, id)

  def list_boards do
    Repo.all(Content.Board)
  end

  def list_quotes do
    Repo.all(Content.Quote)
  end

  def update_board(board_id, board) do
    board_id
    |> find_board
    |> Content.Board.changeset(board)
    |> Repo.update()
  end

  def update_quote(quote_id, qb_quote) do
    quote_id
    |> find_quote
    |> Content.Quote.changeset(qb_quote)
    |> Repo.update()
  end

  def like_quote(user, quote_id) do
    qb_quote = quote_id |> find_quote |> Repo.preload(:likes)
    users = [user | qb_quote.likes] |> Enum.uniq()

    qb_quote
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:likes, users)
    |> Repo.update()
  end

  def unlike_quote(user, quote_id) do
    qb_quote = quote_id |> find_quote |> Repo.preload(:likes)
    users = qb_quote.likes |> List.delete(user)

    qb_quote
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:likes, users)
    |> Repo.update()
  end

  def delete_board(board_id) do
    board_id
    |> find_board
    |> Repo.delete()
  end

  def delete_quote(quote_id) do
    quote_id
    |> find_quote
    |> Repo.delete()
  end
end
