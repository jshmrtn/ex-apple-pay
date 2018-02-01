defmodule ApplePayTest do
  @moduledoc false
  
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest ApplePay, except: [initiate_session: 2]

  alias ApplePay.InitiateSessionBody
  alias ApplePay.Configuration
  alias ExVCR.Config

  describe "initiate_session/2" do
    setup do
      body = %InitiateSessionBody{
        merchant_identifier: "merchant.test.payment.airatel.com",
        domain_name: "lpwpjtywvd.localtunnel.me",
        display_name: "ACME Shop"
      }

      config = %Configuration{
        key: "priv/test/private.pem",
        cert: "priv/test/cert.pem",
        initiate_session_body: body
      }

      {:ok,
       %{
         config: config,
         url: "https://apple-pay-gateway-cert.apple.com/paymentservices/startSession"
       }}
    end

    test "works with valid cert", %{test: test, config: config, url: url} do
      Config.filter_sensitive_data(
        ~S("merchantSessionIdentifier":"[^"]+"),
        ~S("merchantSessionIdentifier":"MERCHANT_SESSION_IDENTIFIER_PLACEHOLDER")
      )

      Config.filter_sensitive_data(
        ~S("merchantIdentifier":"[^"]+"),
        ~S("merchantIdentifier":"MERCHANT_IDENTIFIER_PLACEHOLDER")
      )

      Config.filter_sensitive_data(
        ~S("signature":"[^"]+"),
        ~S("signature":"SIGNATURE_PLACEHOLDER")
      )

      Config.filter_sensitive_data(
        ~S("nonce":"[^"]+"),
        ~S("nonce":"NONCE_PLACEHOLDER")
      )

      use_cassette "#{test}" do
        assert %{
                 "displayName" => "ACME Shop",
                 "domainName" => "lpwpjtywvd.localtunnel.me",
                 "epochTimestamp" => _,
                 "expiresAt" => _,
                 "merchantIdentifier" => "MERCHANT_IDENTIFIER_PLACEHOLDER",
                 "merchantSessionIdentifier" => "MERCHANT_SESSION_IDENTIFIER_PLACEHOLDER",
                 "nonce" => "NONCE_PLACEHOLDER",
                 "signature" => "SIGNATURE_PLACEHOLDER"
               } = ApplePay.initiate_session(config, url)
      end
    end
  end
end
