defmodule Quoteboard.Content.QuoteTest do
  use ExUnit.Case, async: true
  alias Quoteboard.Content.Quote

  @valid_attrs %{
    text: Faker.Lorem.Shakespeare.hamlet(),
    speaker: Faker.Name.name(),
    date_said: Faker.Date.date_of_birth(),
    deleted: true
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Quote.changeset(%Quote{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset without text" do
    changeset = Quote.changeset(%Quote{}, @valid_attrs |> Map.delete(:text))
    refute changeset.valid?
  end

  test "changeset without speaker" do
    changeset = Quote.changeset(%Quote{}, @valid_attrs |> Map.delete(:speaker))
    refute changeset.valid?
  end

  test "changeset without date" do
    changeset = Quote.changeset(%Quote{}, @valid_attrs |> Map.delete(:date_said))
    assert changeset.valid?
  end

  test "changeset without deleted" do
    changeset = Quote.changeset(%Quote{}, @valid_attrs |> Map.delete(:deleted))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Quote.changeset(%Quote{}, @invalid_attrs)
    refute changeset.valid?
  end
end
