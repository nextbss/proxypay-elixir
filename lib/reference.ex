defmodule PaymentReference do
  @derive [Poison.Encoder]
  defstruct [:amount, :end_datetime, :custom_fields]
end
