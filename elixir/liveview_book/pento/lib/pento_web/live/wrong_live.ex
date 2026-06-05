defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def render(assigns) do
    ~H"""
    <main class="px-4 py-20 sm:px-6 lg:px-8">
      <h1 class="mb-4 text-4xl font-extrabold">
        Hey {@current_user.username}. Here is your score: {@score}
      </h1>
      <p>Your role: {@user_role}</p>
      <h2>
        {@message}
      </h2>
      <br />
      <h2>
        <%= for n <- 1..10 do %>
          <.link
            class="btn btn-secondary"
            phx-click="guess"
            phx-value-number={n}
          >
            {n}
          </.link>
        <% end %>
      </h2>
      <p>
        {@answer}
      </p>
      <.link :if={@replay} phx-click="replay">Replay</.link>
    </main>
    """
  end

  def mount(_params, _session, socket) do
    user = socket.assigns.current_scope.user
    role = socket.assigns.current_scope.role

    {:ok,
     assign(socket,
       score: 0,
       message: "Make a guess:",
       answer: :rand.uniform(9) + 1,
       replay: false,
       current_user: user,
       user_role: role
     )}
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    socket =
      if String.to_integer(guess) == socket.assigns.answer do
        socket |> assign(message: "Correct! You win!", score: socket.assigns.score, replay: true)
      else
        socket
        |> assign(
          message: "Your guess: #{guess}. Wrong. Guess again.",
          score: socket.assigns.score - 1
        )
      end

    {
      :noreply,
      socket
    }
  end

  def handle_event("replay", _, socket) do
    {:noreply,
     socket
     |> assign(message: "Make a guess:", score: 0, replay: false, answer: :rand.uniform(9) + 1)}
  end

  def time do
    DateTime.utc_now() |> to_string()
  end
end
