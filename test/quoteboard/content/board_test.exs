defmodule Quoteboard.Content.BoardTest do
  use ExUnit.Case, async: true
  alias Quoteboard.Content.Board

  @valid_attrs %{
    name: Faker.Pokemon.name(),
    description: Faker.Lorem.Shakespeare.hamlet(),
    public: false,
    deleted: true
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Board.changeset(%Board{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset without name" do
    changeset = Board.changeset(%Board{}, @valid_attrs |> Map.delete(:name))
    refute changeset.valid?
  end

  test "changeset without description" do
    changeset = Board.changeset(%Board{}, @valid_attrs |> Map.delete(:description))
    refute changeset.valid?
  end

  test "changeset without public" do
    changeset = Board.changeset(%Board{}, @valid_attrs |> Map.delete(:public))
    assert changeset.valid?
  end

  test "changeset without deleted" do
    changeset = Board.changeset(%Board{}, @valid_attrs |> Map.delete(:deleted))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Board.changeset(%Board{}, @invalid_attrs)
    refute changeset.valid?
  end
end
