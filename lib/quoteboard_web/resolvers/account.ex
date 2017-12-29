defmodule QuoteboardWeb.Resolvers.Account do

  def list_users(_parent, _args, _resolution) do
    {:ok, Quoteboard.Account.list_users()}
  end

  def find_user(_parent, %{id: id}, _resolution) do
    case Quoteboard.Account.find_user(id) do
      nil ->
        {:error, "User ID #{id} not found."}
      user ->
        {:ok, user}
    end
  end

  def update_user(_parent, %{id: id, user: user_params}, _resolution) do
    Quoteboard.Account.update_user(id, user_params)
  end

  # THIS NEEDS TO BE REPLACED WITH AN EMAIL SENDOUT & VERIFICATION SYSTEM > UPDATE ASAP
  def register(_parent, params, _resolution) do
    Quoteboard.Account.create_user(params)
    register_session(params)
  end

  # IDK WHY I DIDN'T EXTRAPOLATE OUT VARS HERE > FIX ?
  def login(_parent, params, _resolution) do
    register_session(params)
  end

  defp register_session(params) do
    with {:ok, user} <- Quoteboard.Account.Session.authenticate(params),
      {:ok, jwt, _} <- Quoteboard.Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt}}
    end
  end

end
