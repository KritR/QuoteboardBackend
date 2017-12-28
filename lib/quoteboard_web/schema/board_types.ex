defmodule Quoteboard.Schema.BoardTypes do
  use Absinthe.Schema.Notation
  import_types Absinthe.Type.Custom

  @desc "A user"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :boards, list_of(:board)
    field :quotes, list_of(:quote)
  end
  
  @desc "A board of quotes"
  object :board do
    field :id, :id
    field :name, :string
    field :description, :string
    field :public, :boolean
    field :deleted, :boolean
    field :owner, :user
    field :quotes, list_of(:quote)
  end

  @desc "A quote"
  object :quote do
    field :id, :id
    field :text, :string
    field :speaker, :string
    field :date_said, :date
    field :deleted, :boolean
    field :owner, :user
    field :boards, list_of(:board)
  end
end
