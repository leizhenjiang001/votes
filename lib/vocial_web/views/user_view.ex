#这也需要我们创建一个视图文件，因为如果没有宏，
#你无法将任何内容呈现给浏览器，除非你有一个，所以创建 lib/vocial_web/views/user_view.ex：
defmodule VocialWeb.UserView do
  use VocialWeb, :view

  #put_flash 是 Phoenix.Controller 模块的一部分。 该模块应该导入到 web/web.ex 中的
  # def controller do 块中，并通过使用 Rumbl.Web 导入，:model

  #您收到错误的原因是 Phoenix.Controller 没有为模型导入。 请注意您的 web.ex 文件中的 def controller do block。
  # 它有一个 use Phoenix.Controller 调用。 这是将导入 put_flash 函数的地方
  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.create_user(user_params) do
      conn
      |> put_flash(:info, "User created!")
      |> redirect(to: user_path(conn, :show, user))
    end
  end


end
