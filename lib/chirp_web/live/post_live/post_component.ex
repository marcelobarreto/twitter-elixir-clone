defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component

  def render(assigns)  do
    ~L"""
      <div id="post-<%= @post.id %>" class="post">
        <div class="row">
          <div class="col col-1">
            <div class="post-avatar">
              <img src="https://avatars.githubusercontent.com/u/1276556?v=4" />
            </div>
          </div>
          <div class="col col-11 post-body">
            <b>@<%= @post.username %></b>
            <br />
            <%= @post.body %>
          </div>
        </div>

        <div class="row">
          <div class="col col-2">
            <a href="#" phx-click="like" phx-target="<%= @myself %>">
              Likes: <%= @post.likes_count %>
            </a>
          </div>
          <div class="col col-2">
            <a href="#" phx-click="repost" phx-target="<%= @myself %>">
              Retweets: <%= @post.reposts_count %>
            </a>
          </div>
          <div class="col col-2">
            <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
              Edit
            <% end %>
            |
            <%= link to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] do %>
              Remove
            <% end %>
          </div>
        </div>
      </div>
    """
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.increment_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.increment_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
