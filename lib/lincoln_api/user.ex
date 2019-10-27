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
end
