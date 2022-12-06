defmodule VocialWeb.UserController do
  use VocialWeb, :controller

  alias Vocial.Accounts

  #将 conn 上的用户值设置为变更集
  def new(conn, _) do
    user = Accounts.new_user()
    render(conn, "new.html", user: user)
  end


  def create(conn, _) do
    conn
  end

  def show(conn, %{"id" => id}) do
    with user <- Accounts.get_user(id), do: render(conn, "show.html",     user: user)
  end


end
