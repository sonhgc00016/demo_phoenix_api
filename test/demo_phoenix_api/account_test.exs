defmodule DemoPhoenixApi.AccountTest do
  use DemoPhoenixApi.DataCase

  alias DemoPhoenixApi.Account

  describe "users" do
    alias DemoPhoenixApi.Account.User

    @valid_attrs %{birth_date: "some birth_date", email: "some email", gender: "some gender", password: "some password", phone_no: "some phone_no", user_name: "some user_name"}
    @update_attrs %{birth_date: "some updated birth_date", email: "some updated email", gender: "some updated gender", password: "some updated password", phone_no: "some updated phone_no", user_name: "some updated user_name"}
    @invalid_attrs %{birth_date: nil, email: nil, gender: nil, password: nil, phone_no: nil, user_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.birth_date == "some birth_date"
      assert user.email == "some email"
      assert user.gender == "some gender"
      assert user.password == "some password"
      assert user.phone_no == "some phone_no"
      assert user.user_name == "some user_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Account.update_user(user, @update_attrs)
      assert user.birth_date == "some updated birth_date"
      assert user.email == "some updated email"
      assert user.gender == "some updated gender"
      assert user.password == "some updated password"
      assert user.phone_no == "some updated phone_no"
      assert user.user_name == "some updated user_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end
end
