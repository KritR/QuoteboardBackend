defmodule Quoteboard.Content.Quote do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quoteboard.Content.Quote


  schema "quotes" do
    field :text, :string
    field :speaker, :string
    field :date_said, :date
    field :deleted, :boolean, default: false
    belongs_to :user, Quoteboard.Account.User
    many_to_many :boards, Quoteboard.Content.Board, join_through: "boards_quotes"

    timestamps()
  end

  @doc false
  def changeset(%Quote{} = quote, attrs) do
    quote
    |> cast(attrs, [:speaker, :text, :date_said, :deleted])
    |> validate_required([:speaker, :text])
  end
end
