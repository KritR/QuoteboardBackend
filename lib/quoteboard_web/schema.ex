defmodule QuoteboardWeb.Schema do
  use Absinthe.Schema
  import_types Absinthe.Type.Custom
  import_types Quoteboard.Schema.ContentTypes
  import_types Quoteboard.Schema.AccountTypes
  
  alias QuoteboardWeb.Resolvers

  query do
    @desc "Get all boards"
    field :boards, list_of(:board) do
      resolve &Resolvers.Content.list_boards/3
    end
    @desc "Get all quotes"
    field :quotes, list_of(:quote) do
      resolve &Resolvers.Content.list_quotes/3
    end
    @desc "Get a single board"
    field :board, type: :board do
      resolve &Resolvers.Content.find_board/3
    end
    @desc "Get a single quote"
    field :quote, type: :quote do
      resolve &Resolvers.Content.find_quote/3
    end
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve &Resolvers.Account.list_users/3
    end
    @desc "Get a single user"
    field :user, type: :user do
      arg :id, non_null(:id)
      resolve &Resolvers.Account.find_user/3
    end
  end

  mutation do
    field :create_board, type: :board do
      arg :name, non_null(:string)      
      arg :description, non_null(:string)      
      resolve &Resolvers.Content.create_board/3
    end
    field :create_quote, type: :quote do
      arg :board_id, non_null(:integer)
      arg :text, non_null(:string)
      arg :speaker, non_null(:string)
      arg :date_said, :date
      resolve &Resolvers.Content.create_quote/3
    end
    field :update_board, type: :board do
      arg :id, non_null(:integer)
      arg :board, :update_board_params
      resolve &Resolvers.Content.update_board/3
    end
    field :update_quote, type: :quote do
      arg :id, non_null(:integer)
      arg :board, :update_quote_params
      resolve &Resolvers.Content.update_quote/3
    end
    field :like_quote, type: :quote do
      arg :id, non_null(:integer)
      resolve &Resolvers.Content.like_quote/3
    end
    field :unlike_quote, type: :quote do
      arg :id, non_null(:integer)
      resolve &Resolvers.Content.unlike_quote/3
    end
    field :update_user, type: :user do
      arg :user, :update_user_params
      resolve &Resolvers.Account.update_user/3
    end
    field :delete_board, type: :board do
      arg :id, non_null(:integer)
      resolve &Resolvers.Content.delete_board/3
    end
    field :delete_quote, type: :quote do
      arg :id, non_null(:integer)
      resolve &Resolvers.Content.delete_quote/3
    end
    field :login, type: :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      resolve &Resolvers.Account.login/3
    end
    field :register, type: :session do
      arg :name, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      resolve &Resolvers.Account.register/3
    end
    #field :logout, type: :session do
    #end
  end

end
