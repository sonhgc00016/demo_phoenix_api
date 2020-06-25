defmodule DemoPhoenixApiWeb.UserView do
  use DemoPhoenixApiWeb, :view
  alias DemoPhoenixApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      phone_no: user.phone_no,
      password: user.password,
      user_name: user.user_name,
      email: user.email,
      birth_date: user.birth_date,
      gender: user.gender
    }
  end
end
