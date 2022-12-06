defmodule Vocial.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Vocial.Accounts.User

  schema "users" do
    field :username, :string
    field :email, :string
    field :active, :boolean, default: true
    field :encrypted_password, :string

    timestamps()
  end

  #我们还没有故意将 encrypted_password 添加到 cast 或 validate_required
  #中的字段列表中！ 后面我们处理密码加密的时候会专门处理这个专栏！
  def changeset(%User{}=user, attrs) do
    user
    |> cast(attrs, [:username, :email, :active])
    |> validate_required([:username, :email, :active])
  end
end
