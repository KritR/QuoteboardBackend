defmodule Quoteboard.Account.Session do
  alias Quoteboard.Account.User
  alias Quoteboard.Repo

  def authenticate(params) do
    user = Repo.get_by(User, email: String.downcase(params.email))

    case check_password(user, params.password) do
      true -> {:ok, user}
      _ -> {:error, "Incorrect login credentials"}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Argon2.checkpw(password, user.password_hash)
    end
  end
end
