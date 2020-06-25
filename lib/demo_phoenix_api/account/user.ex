defmodule DemoPhoenixApi.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "users" do
    field :phone_no, :string, primary_key: true
    field :password, :string
    field :user_name, :string
    field :email, :string
    field :birth_date, :string
    field :gender, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:phone_no, :password, :user_name, :email, :birth_date, :gender])
    |> validate_required([:phone_no, :password, :user_name, :email, :birth_date, :gender])
  end
end
