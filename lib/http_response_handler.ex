defmodule HttpResponseHandler do
  def handle(response) do
    status_code = elem(response, 1).status_code
    if (status_code != 200 || status_code != 201 || status_code != 204) do
        {:error, "Failure: #{elem(response, 1).body}"}
    end

    body = elem(response, 1).body
    if (body == "" and status_code == 204) do
      body = "Reference was created or updated successfully"
      {:ok, body}
    else
      {:ok, body}
    end
  end
end
