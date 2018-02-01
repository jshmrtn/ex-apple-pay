defmodule ApplePay do
  @moduledoc """
  Handle Apple Pay Sessions
  """

  alias ApplePay.Configuration
  alias HTTPoison.Response

  require Logger

  @doc """

  ## Examples:

      iex> body = %ApplePay.InitiateSessionBody{
      ...>   merchant_identifier: "merchant.test.payment.airatel.com",
      ...>   domain_name: "lpwpjtywvd.localtunnel.me",
      ...>   display_name: "ACME Shop"
      ...> }
      iex> config = %ApplePay.Configuration{
      ...>   key: "priv/test/private.pem",
      ...>   cert: "priv/test/cert.pem",
      ...>   initiate_session_body: body
      ...> }
      iex> url = "https://apple-pay-gateway-cert.apple.com/paymentservices/startSession" # Retrieved from Client
      iex> ApplePay.initiate_session(config, url)
      %{...}

  """
  def initiate_session(%Configuration{} = config, url) do
    ssl = [
      certfile: config.cert,
      keyfile: config.key,
      versions: [:"tlsv1.2"]
    ]

    url
    |> HTTPoison.post(
      Jason.encode!(config.initiate_session_body),
      [{"Content-Type", "application/json"}],
      ssl: ssl
    )
    |> case do
      {:ok, %Response{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()

      {:ok, %Response{} = response} ->
        Logger.error("Invalid response from Apple Pay Server: #{inspect(response)}")
        {:error, :invalid_response}

      {:error, error} ->
        {:error, error}
    end
  end
end
