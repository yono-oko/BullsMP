defmodule BullsAndCowsWeb.GameChannel do
  use BullsAndCowsWeb, :channel

  alias BullsAndCows.Game
  alias BullsAndCows.BackupAgent

  @impl true
  def join("game:" <> name, payload, socket) do
    if authorized?(payload) do
      game = BackupAgent.get(name) || Game.new
      # socket = assign(socket, :game, game)
      socket = socket
      |> assign(:name, name)
      |> assign(:game, game)
      BackupAgent.put(name,game)
      view = Game.view(game)
      {:ok, view, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("changeText", %{"text" => text}, socket0) do
    game0 = socket0.assigns[:game]
    game1 = Game.change_text(game0, text)
    socket1 = assign(socket0, :game, game1)
    BackupAgent.put(socket0.assigns[:name], game1)
    view = Game.view(game1)
    {:reply, {:ok, view}, socket1}
  end

  @impl true
  def handle_in("guess", %{"guesses" => word}, socket2) do
    game2 = socket2.assigns[:game]
    game3 = Game.guess(game2, word)
    socket3 = assign(socket2, :game, game3)
    BackupAgent.put(socket2.assigns[:name], game3)
    view = Game.view(game3)
    {:reply, {:ok, view}, socket3}
  end

  @impl true
  def handle_in("reset", _, socket) do
    game = Game.new
    socket1 = assign(socket, :game, game)
    BackupAgent.put(socket.assigns[:name], game)
    view = Game.view(game)
    {:reply, {:ok, view}, socket1}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
