defmodule VocialWeb.PageController do
  use VocialWeb, :controller

  def index(conn, _params) do

    poll = %{
         title: "My First Poll1",
         options: [
          {"Choice 1", 0},
           {"Choice 2", 5},
            {"Choice 3", 2}
             ]
             }

    render(conn, "index.html")
  end
end
