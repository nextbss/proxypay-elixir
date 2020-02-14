defmodule ExProxyPay do
  @sandbox_base_url "https://api.sandbox.proxypay.co.ao"
  @production_base_url "https://api.proxypay.co.ao"
  @payments_uri "/payments"
  @generate_reference_uri "/reference_ids"
  @references "/references"
  @headers [{"Content-Type", "application/json"}, {"Accept", "application/vnd.proxypay.v2+json"}]
  @sandbox_mode "SANDBOX"
  defstruct [:config, :headers]
  
  @spec new(Config.t()) :: ExProxyPay.t()
  def new(config) do
    %__MODULE__{config: config}
  end

  def get_payments(size, config) do
    headers = add_auth_header(config)
    if config.environment == @sandbox_mode do
      HTTPoison.get("#{@sandbox_base_url}#{@payments_uri}?n=#{size}", headers, [])
      |> HttpResponseHandler.handle
    else
      HTTPoison.get("#{@production_base_url}#{@payments_uri}?n=#{size}", headers, [])
      |> HttpResponseHandler.handle
    end
  end

  def acknowledge_payment(id, config) do
    headers = add_auth_header(config)
    if config.environment == @sandbox_mode do
      HTTPoison.delete("#{@sandbox_base_url}#{@payments_uri}/#{id}", headers, [])
      |> HttpResponseHandler.handle
    else 
      HTTPoison.delete("#{@production_base_url}#{@payments_uri}/#{id}", headers, [])
      |> HttpResponseHandler.handle
    end
  end

  def generate_reference_id(config) do
    headers = add_auth_header(config)
    if config.environment == @sandbox_mode do
      HTTPoison.post("#{@sandbox_base_url}#{@generate_reference_uri}", "", headers, [])
      |> HttpResponseHandler.handle
    else
      HTTPoison.post("#{@production_base_url}#{@generate_reference_uri}", "", headers, [])
      |> HttpResponseHandler.handle
    end
  end

  @spec create_reference(any, any, atom | %{api_key: any}) :: {:ok, any}
  def create_reference(id, reference, config) do
    headers = add_auth_header(config)
    body = Poison.encode(reference)
    if config.environment == @sandbox_mode do
      HTTPoison.put("#{@sandbox_base_url}#{@references}/#{id}", elem(body, 1), headers, [])
      |> HttpResponseHandler.handle
    else 
      HTTPoison.put("#{@production_base_url}#{@references}/#{id}", elem(body, 1), headers, [])
      |> HttpResponseHandler.handle
    end
  end

  def delete_reference(id, config) do
    headers = add_auth_header(config)
    if config.envronment == @sandbox_mode do
      HTTPoison.delete("#{@sandbox_base_url}#{@references}/#{id}", headers, [])
      |> HttpResponseHandler.handle
    else
      HTTPoison.delete("#{@production_base_url}#{@references}/#{id}", headers, [])
      |> HttpResponseHandler.handle
    end
  end

  defp add_auth_header(config) do
    @headers ++ [{"Authorization", "Token #{config.api_key}"}]
  end
end
