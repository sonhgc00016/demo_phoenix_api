defmodule DemoPhoenixApiWeb.UserControllerTest do
  use DemoPhoenixApiWeb.ConnCase

  alias DemoPhoenixApi.Account
  alias DemoPhoenixApi.Account.User

  @create_attrs %{
    birth_date: "some birth_date",
    email: "some email",
    gender: "some gender",
    password: "some password",
    phone_no: "some phone_no",
    user_name: "some user_name"
  }
  @update_attrs %{
    birth_date: "some updated birth_date",
    email: "some updated email",
    gender: "some updated gender",
    password: "some updated password",
    phone_no: "some updated phone_no",
    user_name: "some updated user_name"
  }
  @invalid_attrs %{birth_date: nil, email: nil, gender: nil, password: nil, phone_no: nil, user_name: nil}

  def fixture(:user) do
    {:ok, user} = Account.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "some birth_date",
               "email" => "some email",
               "gender" => "some gender",
               "password" => "some password",
               "phone_no" => "some phone_no",
               "user_name" => "some user_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "some updated birth_date",
               "email" => "some updated email",
               "gender" => "some updated gender",
               "password" => "some updated password",
               "phone_no" => "some updated phone_no",
               "user_name" => "some updated user_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
