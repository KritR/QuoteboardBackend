defmodule Quoteboard.Repo.Migrations.CreateQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :speaker, :string
      add :text, :text
      add :date_said, :date
      add :deleted, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:quotes, [:owner_id])
  end
end
