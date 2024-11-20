defmodule RaffleyWeb.RaffleLive.Index do
  use RaffleyWeb, :live_view

  alias Raffley.Raffles
  import RaffleyWeb.CustomComponents

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
      <.banner>
        <.icon name="hero-sparkles" /> Mystery Raffle Coming Soon!
      </.banner>
      <div class="raffles">
        <.raffle :for={raffle <- @raffles} raffle={raffle} />
      </div>
    </div>
    """
  end

  slot :inner_block, required: true

  def banner(assigns) do
    ~H"""
    <div class="banner">
      <h1>
        <%= render_slot(@inner_block) %>
      </h1>
    </div>
    """
  end

  attr :raffle, Raffley.Raffle

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
end
