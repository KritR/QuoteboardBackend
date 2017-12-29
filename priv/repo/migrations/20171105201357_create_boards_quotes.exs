defmodule Quoteboard.Repo.Migrations.CreateBoardsQuotes do
  use Ecto.Migration

  def change do
    create table(:boards_quotes, primary_key: false) do
      add :board_id, references(:boards, on_delete: :delete_all)
      add :quote_id, references(:quotes, on_delete: :delete_all)
    end
  end
end
