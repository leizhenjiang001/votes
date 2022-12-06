defmodule VocialWeb.PollController do
  use VocialWeb, :controller
  alias Vocial.Votes
  #controller告诉phoenix怎么去处理路由  通过函数处理浏览器请求get,post 跳转html
  #在构建 UI 时，您最终会适应的工作流程是同时打开控制器和模板。 这是保持代码从 A 点到 B 点逻辑流动的好方法


  #
  def index(conn, _params) do
    polls = Vocial.Votes.list_polls()
    render conn, "index.html", polls: polls
    ##render(conn, "index.html")
    #polls = %{
    #  title: "My First Poll",
    #  options: [
    #    {"Choice 1",1},
    #    {"Choice 2",5},
    #    {"Choice 3",2}
    #  ]
    #}

    #conn
    #|> put_layout(:special)
    #|> render("index.html", polls: polls)
  end

  def new(conn, _params) do
     poll = Votes.new_poll()
     render conn, "new.html", poll: poll
  end

  #为了解决报错自己重新定义的函数
  def poll_path(conn, _params) do
    poll = Votes.new_poll()
    render conn, "new.html", poll: poll
  end

  #我们有一个新的表单将数据发送到我们的创建控制器操作，但实际上没有处理它。
  #我们将跳回到 lib/vocial_web/controllers/poll_controller.ex 并添加一个新的创建函数create和模式匹配如下：
  def create(conn, %{"poll" => poll_params, "options" => options}) do
    split_options = String.split(options, ",")
    with {:ok, poll} <- Votes.create_poll_with_options(poll_params, split_options) do
      conn
      |> put_flash(:info, "Poll created successfully!")
      |> redirect(to: poll_path(conn, :index))
    end
  end

end
