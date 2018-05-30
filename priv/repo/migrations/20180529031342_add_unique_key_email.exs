defmodule Quoteboard.Repo.Migrations.AddUniqueKeyEmail do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify(:email, :string, size: 254)
    end
    create unique_index :users, [:email], name: :user_email_index
  end
end
