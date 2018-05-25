defmodule Quoteboard.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :quote_id, references(:quotes, on_delete: :delete_all)
    end
  end
end
