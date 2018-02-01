defmodule ApplePay.InitiateSessionBody do
  @moduledoc """
  Body to be sent with Session Initialization
  """

  alias ApplePay.InitiateSessionBody

  @type t :: %__MODULE__{
          merchant_identifier: String.t(),
          domain_name: String.t(),
          display_name: String.t()
        }

  @enforce_keys [
    :merchant_identifier,
    :domain_name,
    :display_name
  ]
  defstruct @enforce_keys

  defimpl Jason.Encoder, for: __MODULE__ do
    alias Jason.Encode

    def encode(%InitiateSessionBody{} = body, opts) do
      body
      |> Map.from_struct()
      |> Enum.map(fn {key, value} ->
        normalized =
          key
          |> Atom.to_string()
          |> Macro.camelize()
          |> decapitalize

        {normalized, value}
      end)
      |> Enum.into(%{})
      |> Encode.map(opts)
    end

    defp decapitalize(<<first::bytes-size(1)>> <> rest) do
      String.downcase(first) <> rest
    end
  end
end
