defmodule ApplePay.Configuration do
  @moduledoc """
  Configuration for the Session Initialization
  """

  alias ApplePay.InitiateSessionBody

  @type t :: %__MODULE__{
          cert: String.t(),
          key: String.t(),
          initiate_session_body: InitiateSessionBody.t()
        }

  @enforce_keys [:key, :cert, :initiate_session_body]
  defstruct @enforce_keys
end
