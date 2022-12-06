#We'll want to define this as a module, use the DataCase macros
#and alias the relevant other modules in our codebase (accounts and repo).
#Next, we'll build up a describeblock for the user-related functionality in our context.
defmodule Vocial.AccountsTest do
  use Vocial.DataCase

  alias Vocial.Accounts

  describe "users" do
    @valid_attrs %{ username: "test", email: "test@test.com", active: true }

    def user_fixture(attrs \\ %{}) do
      with create_attrs <- Map.merge(@valid_attrs, attrs),
           {:ok, user} <- Accounts.create_user(create_attrs)
      do
        user
      end
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end
  end
end
