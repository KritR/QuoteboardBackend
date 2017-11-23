defmodule Quoteboard.Boards.Quote do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quoteboard.Boards.Quote


  schema "quotes" do
    field :date, :date
    field :deleted, :boolean, default: false
    field :speaker, :string
    field :text, :string
    field :owner_id, :id
    belongs_to :user, Quoteboard.Account.User
    many_to_many :boards, Quoteboard.Boards.Board, join_through: "boards_quotes"

    timestamps()
  end

  @doc false
  def changeset(%Quote{} = quote, attrs) do
    quote
    |> cast(attrs, [:speaker, :text, :date, :deleted])
    |> validate_required([:speaker, :text, :date, :deleted])
  end
end
