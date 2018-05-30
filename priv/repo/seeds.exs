# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.edo
#
# Inside the script, you can read and write to any of your
# repositories direct
#
#     Quoteboard.Repo.insert!(%Quoteboard.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`

# and so on) as they will fail if something goes wrong.
alias Quoteboard.Repo
alias Quoteboard.Content.{Quote, Board}
alias Quoteboard.Account.{User}

defmodule SeedGen do
  def create_user(boards \\ []) do
    pw = Faker.Pizza.pizza()

    %User{
      name: Faker.Name.name(),
      email: Faker.Internet.email(),
      password: pw,
      password_hash: Comeonin.Argon2.hashpwsalt(pw),
      boards: boards
    }
  end

  def create_board do
    %Board{
      name: Faker.Pokemon.name(),
      description: Faker.Lorem.Shakespeare.hamlet()
    }
  end

  def insert_quote(user, board) do
    qb_quote = %{
      :text => Faker.Lorem.Shakespeare.romeo_and_juliet(),
      :speaker => Faker.Name.name(),
      :date_said => Faker.Date.date_of_birth()
    }

    Ecto.build_assoc(user, :quotes)
    |> Quote.changeset(qb_quote)
    |> Ecto.Changeset.put_assoc(:boards, [board])
    |> Repo.insert!()
  end
end

users =
  0..Enum.random(5..20)
  |> Enum.map(fn _ ->
    0..Enum.random(0..5) |> Enum.map(fn _ -> SeedGen.create_board() end) |> SeedGen.create_user()
  end)
  |> Enum.map(&Repo.insert!/1)

Enum.each(users, fn user ->
  %{boards: boards} = user

  Enum.each(boards, fn board ->
    0..Enum.random(0..4) |> Enum.each(fn _ -> SeedGen.insert_quote(user, board) end)
  end)
end)
