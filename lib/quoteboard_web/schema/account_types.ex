defmodule Quoteboard.Schema.AccountTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Quoteboard.Repo

  @desc "A user"
  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
    field(:boards, list_of(:board), resolve: assoc(:boards))
    field(:quotes, list_of(:quote), resolve: assoc(:quotes))
    field(:likes, list_of(:quote), resolve: assoc(:likes))
  end

  input_object :update_user_params do
    field(:name, :string)
    field(:email, :string)
    field(:password, :string)
  end

  object :session do
    field(:token, :string)
  end
end
