defmodule Quoteboard.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quoteboard.Account.User


  schema "users" do
    field :email, :string
    field :name, :string
    has_many :boards, Quoteboard.Boards.Board
    has_many :quotes, Quoteboard.Boards.Quote

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
