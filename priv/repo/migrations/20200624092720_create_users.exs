defmodule DemoPhoenixApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :phone_no, :string, size: 15, primary_key: true
      add :password, :string, null: false
      add :user_name, :string, null: false
      add :email, :string, null: false
      add :birth_date, :string, size: 8
      add :gender, :string, size: 5

      timestamps()
    end

    create unique_index(:users, [:user_name])
    create unique_index(:users, [:email])
  end
end
