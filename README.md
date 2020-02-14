# ExProxypay
[![](https://img.shields.io/badge/proxypay-elixir-blue)](https://developer.proxypay.co.ao/v2/)
[![](https://img.shields.io/badge/nextbss-opensource-blue.svg)](https://www.nextbss.co.ao)

**A library that helps you easily interact with the ProxyPay API using the elixir programming language.**


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_proxypay` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_proxypay, "~> 0.1.0"}
  ]
end
```

### Create a payment request with ProxyPay
Full code to create a payment request using ProxyPay.
```elixir
  config = %Config{api_key: "YOUR_API_KEY", environment: "SANDBOX"}
  {state, id} = ExProxyPay.generate_reference_id(config)
  ExProxyPay.create_reference(id, %PaymentReference{amount: 100, end_datetime: "2020/03/14", custom_fields: nil}, config)
```

output: 
```terminal
  {:ok, "Reference was created or updated successfully"}
```

### Configure ProxyPay api key and environment:
To interact with ProxyPay you will need to define the environment to interact with and the api key for authentication.

You have at your disposal two environments: "SANDBOX" and "PRODUCTION".

```elixir
  config = Config.init(%{api_key: "YOUR_API_KEY", environment: "SANDBOX"})
```

### Get Payments
Returns Payment events stored on the server that were not yet Acknowledged

```elixir
  ExProxyPay.get_payments(n, config)
```

### Create reference id
This function generates a unique Reference Id to be associated with a given payment reference

```elixir
  {state, id} = ExProxyPay.generate_reference_id(config)
```

### Create Reference using reference id
The generateReference method creates or updates a payment reference with given Id
```elixir
  reference = %PaymentReference{amount: 100, end_datetime: "2020/03/14", custom_fields: nil}
  ExProxyPay.create_reference(id, reference, config)
```

### Delete Reference
This endpoint deletes a reference with given Id

```elixir
  ExProxyPay.delete_reference(id, config)
```

### Acknowledge a payment
This method is used to acknowledge that a payment was processed

```elixir
  ExProxyPay.acknowledge_payment(id, config)
```


License
----------------

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
