defmodule Quoteboard.Boards.Board do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quoteboard.Boards.Board


  schema "boards" do
    field :deleted, :boolean, default: false
    field :description, :string
    field :name, :string
    field :public, :boolean, default: false
    field :owner_id, :id
    belongs_to :user, Quoteboard.Account.User
    many_to_many :quotes, Quoteboard.Boards.Quote, join_through: "boards_quotes"

    timestamps()
  end

  @doc false
  def changeset(%Board{} = board, attrs) do
    board
    |> cast(attrs, [:name, :description, :public, :deleted])
    |> validate_required([:name, :description, :public, :deleted])
  end
end
