defmodule DemoPhoenixApiWeb.UserController do
  use DemoPhoenixApiWeb, :controller

  alias DemoPhoenixApi.Account
  alias DemoPhoenixApi.Account.User

  action_fallback DemoPhoenixApiWeb.FallbackController

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"phone_no" => phone_no}) do
    user = Account.get_user!(phone_no)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"phone_no" => phone_no, "user" => user_params}) do
    user = Account.get_user!(phone_no)

    with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"phone_no" => phone_no}) do
    user = Account.get_user!(phone_no)

    with {:ok, %User{}} <- Account.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
