defmodule Quoteboard.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quoteboard.Account.User

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    has_many(:boards, Quoteboard.Content.Board)
    has_many(:quotes, Quoteboard.Content.Quote)
    many_to_many(:likes, Quoteboard.Content.Quote, join_through: "likes")
    field(:password, :string, virtual: true)
    field(:password_hash, :string)

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_length(:password, min: 8)
    |> validate_required([:name, :email])
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, ~r/^\w+@\w+\.\w{2,}$/)
    |> unique_constraint(:email, name: :user_email_index)
    |> put_pass_hash
  end

  def registration_changeset(%User{} = user, params \\ %{}) do
    user
    |> cast(params, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_length(:password, min: 8)
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, ~r/^\w+@\w+\.\w{2,}$/)
    |> unique_constraint(:email, name: :user_email_index)
    |> put_pass_hash
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Argon2.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
