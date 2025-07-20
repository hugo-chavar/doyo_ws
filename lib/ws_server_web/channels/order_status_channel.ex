defmodule WsServerWeb.OrderStatusChannel do
  use WsServerWeb, :channel
  require Logger

  @impl true
  def join("order:" <> order_id, payload, socket) do
    IO.puts("Order: " <> order_id)
    IO.inspect(payload)
    if authorized?(payload) do
      Logger.debug("Client joined order #{order_id}")
      {:ok, assign(socket, :order_id, order_id)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
