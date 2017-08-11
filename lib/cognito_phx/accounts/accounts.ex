defmodule CognitoPhx.Accounts do
  @moduledoc """
  The Accounts context
  """

  alias CognitoPhx.Accounts.User

  def find_user!(id) do
    # Repo.get!(User, id)
  end

  def sign_up(email, password, password_confirm) do
    if password != password_confirm do
      {:error, "The two password fields must match!"}
    else
      AWS.Cognito.IdentityProvider.sign_up(
        client(),
        %{
           "ClientId": Application.get_env(:aws, :client_id),
           "UserPoolId": Application.get_env(:aws, :user_pool_id),
           "Username": email,
           "Password": password
         }
        )
    end
  end

  def confirm(email, confirmation_code) do
    AWS.Cognito.IdentityProvider.confirm_sign_up(
      client(),
      %{
          "ClientId": Application.get_env(:aws, :client_id),
          "Username": email,
          "ConfirmationCode": confirmation_code
        }
      )
  end

  def authenticate(email, password) do
    AWS.Cognito.IdentityProvider.admin_initiate_auth(
      client(),
      %{
         "AuthFlow": "ADMIN_NO_SRP_AUTH",
         "ClientId": Application.get_env(:aws, :client_id),
         "UserPoolId": Application.get_env(:aws, :user_pool_id),
         "AuthParameters": %{
            "USERNAME": email,
            "PASSWORD": password
          },
       }
      )
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    # |> Repo.insert()
  end

  @doc """
  """
  defp client do
    %AWS.Client{
      access_key_id: Application.get_env(:aws, :key),
      secret_access_key: Application.get_env(:aws, :secret),
      region: Application.get_env(:aws, :region),
      endpoint: "amazonaws.com",
    }
  end
end
