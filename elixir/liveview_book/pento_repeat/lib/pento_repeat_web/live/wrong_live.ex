defmodule PentoRepeatWeb.WrongLive do
  use PentoRepeatWeb, :live_view

  def render(assigns) do
    ~H"""
    <main class="mx-auto w-100">
      <div class="flex flex-col gap-8 mt-16">
        <h1 class="text-lg">
          You score: {@score}
        </h1>
        <p>{@message}({@answer})</p>
        <div class="flex flex-row gap-4">
          <.link
            :for={number <- 1..10}
            class="btn btn-secondary"
            type="button"
            phx-click="guess"
            phx-value-guess={number}
          >
            {number}
          </.link>
        </div>
        <.button :if={@replay} variant="primary" phx-click="replay">
          Replay
        </.button>
      </div>
    </main>
    """
  end

  def mount(_param, _session, socket) do
    {:ok,
     socket
     |> assign(score: 0, message: "Make a guess", replay: false, answer: :rand.uniform(9) + 1)}
  end

  # def handle_event("guess", %{"number" => guess}, socket) do
  def handle_event("guess", %{"guess" => guess}, socket) do
    if String.to_integer(guess) == socket.assigns.answer do
      {:noreply, socket |> assign(message: "Correct Answer!", replay: true)}
    else
      {:noreply, socket |> assign(message: "Wrong Answer!", score: socket.assigns.score - 1)}
    end
  end

  def handle_event("replay", _, socket) do
    {:noreply,
     socket
     |> assign(message: "Make a guess", score: 0, replay: false, answer: :rand.uniform(9) + 1)}
  end
end
