#Creating our accounts context
defmodule Vocial.Accounts do
  import Ecto.Query, warn: false

  alias Vocial.Repo
  alias Vocial.Accounts.User

  #我们能够使用上下文的辅助函数将用户插入到我们的数据库中
  #该函数将只返回我们系统中每个用户的列表
  def list_users, do: Repo.all(User)

  def new_user, do: User.changeset(%User{}, %{})

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user(id), do: Repo.get(User, id)


end
