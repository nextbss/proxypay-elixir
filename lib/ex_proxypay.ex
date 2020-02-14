defmodule ExProxyPay do
  @sandbox_base_url "https://api.sandbox.proxypay.co.ao"
  @production_base_url "https://api.sandbox.proxypay.co.ao"
  @payments_uri "/payments"
  @generate_reference_uri "/reference_ids"
  @references "/references"
  @headers [{"Content-Type", "application/json"}, {"Accept", "application/vnd.proxypay.v2+json"}]
  defstruct [:config, :headers]


  @spec new(Config.t()) :: ExProxyPay.t()
  def new(config) do
    %__MODULE__{config: config}
  end

  def get_payments(size, config) do
    headers = add_auth_header(config)
    response = HTTPoison.get("#{@sandbox_base_url}#{@payments_uri}?n=#{size}", headers, [])
    HttpResponseHandler.handle(response)
  end

  def acknowledge_payment(id, config) do
    headers = add_auth_header(config)
    response = HTTPoison.delete("#{@sandbox_base_url}#{@payments_uri}/#{id}", headers, [])
    HttpResponseHandler.handle(response)
  end

  def generate_reference_id(config) do
    headers = add_auth_header(config)
    response = HTTPoison.post("#{@sandbox_base_url}#{@generate_reference_uri}", "", headers, [])
    HttpResponseHandler.handle(response)
  end

  @spec create_reference(any, any, atom | %{api_key: any}) :: {:ok, any}
  def create_reference(id, reference, config) do
    headers = add_auth_header(config)
    body = Poison.encode(reference)
    response = HTTPoison.put("#{@sandbox_base_url}#{@references}/#{id}", elem(body, 1), headers, [])
    HttpResponseHandler.handle(response)
  end

  def delete_reference(id, config) do
    headers = add_auth_header(config)
    response = HTTPoison.delete("#{@sandbox_base_url}#{@references}/#{id}", headers, [])
    HttpResponseHandler.handle(response)
  end

  defp add_auth_header(config) do
    @headers ++ [{"Authorization", "Token #{config.api_key}"}]
  end
end
