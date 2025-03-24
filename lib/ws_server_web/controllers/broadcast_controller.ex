defmodule WsServerWeb.BroadcastController do
  use WsServerWeb, :controller

  def test(conn, _params) do
    WsServerWeb.Endpoint.broadcast("order_status:lobby", "update", %{
      status: "Order shipped!",
      order_id: "12345"
    })
    json(conn, %{message: "Broadcast sent"})
  end
end
