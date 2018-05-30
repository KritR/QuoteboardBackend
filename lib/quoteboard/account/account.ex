defmodule Quoteboard.Account do
  import Ecto.Query
  import Ecto.Changeset

  alias Quoteboard.{Repo, Account}

  def list_users do
    Repo.all(Account.User)
  end

  def find_user(id) do
    Repo.get(Account.User, id)
  end

  def update_user(id, user) do
    Repo.get!(Account.User, id)
    |> Account.User.changeset(user)
    |> Repo.update()
  end

  def create_user(user) do
    %Account.User{}
    |> Account.User.registration_changeset(user)
    |> change(email: String.downcase(user.email))
    |> Repo.insert()
  end
end
