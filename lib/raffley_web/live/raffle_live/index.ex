defmodule RaffleyWeb.RaffleLive.Index do
  use RaffleyWeb, :live_view

  alias Raffley.Raffles

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        raffles: Raffles.list_raffles()
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="raffle-index">
      <div class="raffles">
        <.raffle :for={raffle <- @raffles} raffle={raffle} />
      </div>
    </div>
    """
  end

  def raffle(assigns) do
    ~H"""
    <div class="card">
      <img src={@raffle.image_path} alt={@raffle.id} />
      <h2><%= @raffle.prize %></h2>
      <div class="details">
        <div class="price">
          $<%= @raffle.ticket_price %> / ticket
        </div>
        <.badge status={@raffle.status} />
      </div>
    </div>
    """
  end

  attr :status, :atom, values: [:upcoming, :open, :closed], default: :upcoming

  def badge(assigns) do
    ~H"""
    <div class="badge">
      <%= @status %>
    </div>
    """
  end
end
