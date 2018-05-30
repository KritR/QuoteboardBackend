defmodule Quoteboard.Auth.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :quoteboard

  plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end
