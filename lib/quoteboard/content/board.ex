defmodule Quoteboard.Content.Board do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quoteboard.Content.Board

  schema "boards" do
    field(:name, :string)
    field(:description, :string)
    field(:public, :boolean, default: false)
    field(:deleted, :boolean, default: false)
    belongs_to(:user, Quoteboard.Account.User)
    many_to_many(:quotes, Quoteboard.Content.Quote, join_through: "boards_quotes")

    timestamps()
  end

  @doc false
  def changeset(%Board{} = board, attrs) do
    board
    |> cast(attrs, [:name, :description, :public, :deleted])
    |> validate_required([:name, :description, :public, :deleted])
  end
end
