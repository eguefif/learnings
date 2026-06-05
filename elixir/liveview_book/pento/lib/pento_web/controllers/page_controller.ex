defmodule PentoWeb.PageController do
  use PentoWeb, :controller

  def home(conn, _params) when is_nil(conn.current_scope) do
    render(conn, :home)
  end

  def home(conn, _params) do
    redirect(conn, to: "/guess")
  end
end
