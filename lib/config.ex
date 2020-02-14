defmodule Config do
  defstruct [:api_key, :environment]

  def init(%{api_key: api_key, environment: environment}) do
    %__MODULE__{api_key: api_key, environment: environment}
  end
end
