defmodule Quoteboard.Content do
  import Ecto.Query

  alias Quoteboard.{Repo, Content}

  def list_boards do
    Repo.all(Content.Board)
  end

end
