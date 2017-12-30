defmodule Quoteboard.Guardian do
  use Guardian, otp_app: :quoteboard
  require Logger

  alias Quoteboard.Account

  def subject_for_token(user = %Account.User{}, _claims), do: { :ok, "User:#{user.id}" }
  def subject_for_token(_, _claims), do: { :error, "Unknown resource type" }

  def resource_from_claims(%{"sub" => "User:" <> id}), do: { :ok, Account.find_user(id) }
  def resource_from_claims(_claims), do: { :error, "Unknown resource type" }

end
