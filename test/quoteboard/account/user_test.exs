defmodule Quoteboard.Account.UserTest do
  use ExUnit.Case, async :: true
  alias Quoteboard.Account.User

  @valid_attrs %{
    name: Faker.Name.name(),
    email: Faker.Internet.email(),
    password: Faker.Pokemon.name()
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset without name" do
    changeset = User.changeset(%User{}, @valid_attrs |> Map.delete(:name))
    refute changeset.valid?
  end

  test "changeset without email" do
    changeset = User.changeset(%User{}, @valid_attrs |> Map.delete(:email))
    refute changeset.valid?
  end

  test "changeset without password" do
    changeset = User.changeset(%User{}, @valid_attrs |> Map.delete(:password))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
