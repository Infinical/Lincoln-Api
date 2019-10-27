defmodule LincolnApiWeb.API.V1.SessionView do
  use LincolnApiWeb, :view
  alias LincolnApiWeb.API.V1.SessionView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, SessionView, "user.json", as: :user)}
  end

  def render("show.json", %{user: user}) do
    %{
      message: "User Updated Successfully",
      data: render_one(user, SessionView, "user.json", as: :user)
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role
    }
  end
end
