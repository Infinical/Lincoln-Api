defmodule LincolnApi.Accounts do
  @moduledoc """
  The User context.
  """

  import Ecto.Query, warn: false
  alias LincolnApi.Repo
  alias LincolnApi.Users.User

  def list_users do
    Repo.all(User)
  end

  def list_supervisors do
    query = from(m in User, where: m.role == "supervisor")
    Repo.all(query)
  end

  def user_details!(id) do
    Repo.get!(User, id)
  end
end
