defmodule ApplePay.InitiateSessionBodyTest do
  @moduledoc false

  use ExUnit.Case

  alias ApplePay.InitiateSessionBody
  doctest InitiateSessionBody

  describe "Jason.Encoder" do
    body = %InitiateSessionBody{
      merchant_identifier: "foo",
      domain_name: "bar",
      display_name: "baz"
    }

    result =
      body
      |> Jason.encode!()
      |> Jason.decode!()

    assert %{"displayName" => "baz", "domainName" => "bar", "merchantIdentifier" => "foo"} =
             result
  end
end
