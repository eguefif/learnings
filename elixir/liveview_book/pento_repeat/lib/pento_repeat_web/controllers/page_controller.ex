defmodule PentoRepeatWeb.PageController do
  use PentoRepeatWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
