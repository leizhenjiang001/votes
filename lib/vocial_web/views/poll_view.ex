# create a complete file
defmodule VocialWeb.PollView do
  use VocialWeb, :view


    #为了解决报错自己重新定义的函数



  #为了解决报错自己重新定义的函数

  def render("option.json", %{option: option}) do
       %{id: option.id, value: option.value}
       %{
         id: option.id,
         value: option.value,
         vote_count: option.vote_count
       }
  end


end
