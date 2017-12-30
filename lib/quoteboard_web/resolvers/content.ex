defmodule QuoteboardWeb.Resolvers.Content do
  alias Quoteboard.Content

  def create_board(_parent, args, %{context: %{current_user: user}}) do
    Content.create_board(user, args)
  end
  def create_board(_parent, _args, _resolution), do: {:error, "This operation requires authentication"}

  def create_quote(_parent, %{board_id: id} = args, %{context: %{current_user: %{id: user_id} = user}}) do
    board = Content.find_board(id) 
    case board.user_id do
      ^user_id -> Content.create_quote(user, board, args)
      _ -> {:error, "You do not have access to add to this board"}
    end
  end
  def create_quote(_parent, _args, _resolution), do: {:error, "This operation requires authentication"}

  def find_board(_parent, %{id: id}, _resolution) do
    Content.find_board(id)
  end

  def find_quote(_parent, %{id: id}, _resolution) do
    Content.find_quote(id)
  end

  def list_boards(_parent, _args, _resolution) do
    {:ok, Content.list_boards()}
  end

  def list_quotes(_parent, _args, _resolution) do
    {:ok, Content.list_quotes()}
  end

  def update_board(_parent, %{id: id, board: board_params}, %{context: %{current_user: %{id: user_id}}}) do
    case Content.find_board(id).user_id do
      ^user_id -> Content.update_board(id, board_params)
      _ -> {:error, "You do not have access to modify this board"}
    end
  end
  def update_board(_parent, _args, _resolution), do: {:error, "This operation requires authentication"}

  def update_quote(_parent, %{id: id, quote: quote_params}, %{context: %{current_user: %{id: user_id}}}) do
    case Content.find_quote(id).user_id do
      ^user_id -> Content.update_quote(id, quote_params)
      _ -> {:error, "You do not have access to modify this quote"}
    end
  end
  def update_quote(_parent, _args, _resolution), do: {:error, "This operation requires authentication"}

  def delete_board(_parent, %{id: id}, %{context: %{current_user: %{id: user_id}}}) do
    case Content.find_board(id).user_id do
      ^user_id -> Content.delete_board(id)
      _ -> {:error, "You do not have access to modify this board"}
    end
  end
  def delete_board(_parent, _args, _resolution), do: {:error, "This operation requires authentication"}

  def delete_quote(_parent, %{id: id}, %{context: %{current_user: %{id: user_id}}}) do
    case Content.find_quote(id).user_id do
      ^user_id -> Content.delete_quote(id)
      _ -> {:error, "You do not have access to modify this quote"}
    end
  end
  def delete_quote(_parent, _args, _resolution), do: {:error, "This operation requires authentication"}

end
