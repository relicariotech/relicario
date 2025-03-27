defmodule RelicarioWeb.HomeLive do
  use RelicarioWeb, :live_view

  # import RelicarioWeb.CustomComponents

  on_mount RelicarioWeb.RestoreLocale

  def handle_params(params, _uri, socket) do
    locale = Map.get(params, "locale", socket.assigns[:locale] || "en")

    metadata_url = RelicarioWeb.Endpoint.url() <> "/#{locale}"

    socket =
      socket
      |> assign(
        locale: locale,
        base_url_for_locale: ~p"/",
        page_title: gettext("Learn LiveView now!"),
        page_description: gettext("Product development for the business that want to thrive."),
        metadata_url: metadata_url,
        show_hero: true
      )

    {:noreply, socket}
  end
end
