defmodule PentoWeb.PageController do
  use PentoWeb, :controller

  def home(%Plug.Conn{assigns: %{current_scope: nil}} = conn, _params) do
    render(conn, :home)
  end

  def home(conn, _params) do
    redirect(conn, to: "/guess")
  end
end
