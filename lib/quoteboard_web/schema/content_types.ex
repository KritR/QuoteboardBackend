defmodule Quoteboard.Schema.ContentTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Quoteboard.Repo
  
  @desc "A board of quotes"
  object :board do
    field :id, :id
    field :name, :string
    field :description, :string
    field :public, :boolean
    field :deleted, :boolean
    field :owner, :user, resolve: assoc(:user)
    field :quotes, list_of(:quote), resolve: assoc(:quotes)
  end

  @desc "A quote"
  object :quote do
    field :id, :id
    field :text, :string
    field :speaker, :string
    field :date_said, :date
    field :deleted, :boolean
    field :owner, :user, resolve: assoc(:user)
    field :boards, list_of(:board), resolve: assoc(:boards)
    field :likes, list_of(:user), resolve: assoc(:likes)
  end

  input_object :update_board_params do
    field :name, :string      
    field :description, :string      
  end
  
  input_object :update_quote_params do
    field :text, :string
    field :speaker, :string
    field :date_said, :date
  end
end
