defmodule Vocial.Votes do
  import Ecto.Query, warn: false

  alias Vocial.Repo
  alias Vocial.Votes.Poll
  alias Vocial.Votes.Option
  #查询
  def list_polls do
    Repo.all(Poll) |> Repo.preload(:options)
  end

  def new_poll do
     Poll.changeset(%Poll{}, %{})
  end
  #我们希望看到 poll 和 options 参数都被传入。我们知道我们的选项也应该是逗号连接的投票选项列表。我们将假设我们的 createfunction 将如何在我们的 上下文
  #我们假设我们将创建一个方便的 create_poll_with_options 函数，它将接受轮询参数和要添加到该轮询的选项列表。
  #然后我们将使用 Elixir with 语句来确保我们从该函数获得的结果是有意义的

  #我们将首先将整个事情包装在一个transaction中。 Repo.transaction 语句将一个函数作为其唯一参数，并期望操作完成或发出回滚（通过 Repo.rollback() 函数）
  #所以我们在这之后有另一个 with 语句，其中第一个检查是调用 一个任意的 create_poll 函数，第二个检查是一个 create_options 函数，它接受选项列表和数据库创建的轮询
  #（我们需要它来将选项链接回适当的 poll_id）
  #如果一切顺利，我们将返回结果民意测验； 否则，我们将回滚整个交易！
  def create_poll_with_options(poll_attrs, options) do
    Repo.transaction(fn ->
      with {:ok, poll} <- create_poll(poll_attrs),
           {:ok, _options} <- create_options(options, poll)  do
        poll
      else
        _ -> Repo.rollback("Failed to create poll")
      end
    end)
  end

  #接下来，我们将编写我们的 create_poll 函数，这是一个非常简单的函数。 它只是从一个空白的 Poll 结构开始，
  #将其传递到 Poll schema 上的变更集函数，然后最终将整个内容插入到 Repo.Repo.insert()。
  #如果成功，它将以 {:ok, returned_struct_from_db} 格式返回数据：
  def create_poll(attrs) do
    %Poll{}
    |> Poll.changeset(attrs)
    |> Repo.insert()
  end

  #接下来，我们需要创建一个 create_options 函数，它将遍历选项列表，将 poll_id 添加到每个投票标题，并创建每个投票。
  #如果有任何失败，整个事情都应该失败并回滚事务。 如果一切顺利，我们应该返回创建的选项：
  def create_options(options, poll) do
    results = Enum.map(options, fn option ->
      create_option(%{title: option, poll_id: poll.id})
    end)

    if Enum.any?(results, fn {status, _} -> status == :error end) do
      {:error, "Failed to create an option"}
    else
      {:ok, results}
    end
  end

  #最后，这个拼图的最后一块； 我们需要单独的 create_option 函数，它基本上是 create_poll 函数的复制粘贴：
  def create_option(attrs) do
    %Option{}
    |> Option.changeset(attrs)
    |> Repo.insert()
  end

end
