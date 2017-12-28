defmodule Quoteboard.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :name, :string
      add :description, :text
      add :public, :boolean, default: true, null: true
      add :deleted, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:boards, [:owner_id])
  end
end
