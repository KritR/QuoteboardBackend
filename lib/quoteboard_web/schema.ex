defmodule QuoteboardWeb.Schema do
  use Absinthe.Schema
  import_types Quoteboard.Schema.BoardTypes
  
  alias QuoteboardWeb.Resolvers

  query do
    @desc "Get all boards"
    field :boards, list_of(:board) do
      resolve &Resolvers.Board.list_boards/3
    end
  end

end
