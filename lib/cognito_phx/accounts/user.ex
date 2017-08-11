defmodule CognitoPhx.Accounts.User do
  @moduledoc """
  The User model
  """
  defstruct [:email, :username, :password]

  alias CognitoPhx.Accounts.User

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    # |> cast(attrs, [:email])
    # |> validate_required([:email])
  end
end
