defmodule QuoteboardWeb.Context do
  @behaviour Plug
  require Logger

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case Quoteboard.Guardian.Plug.current_resource(conn) do
      nil -> conn
      user -> put_private(conn, :absinthe, %{context: %{current_user: user}})
    end
  end
end
