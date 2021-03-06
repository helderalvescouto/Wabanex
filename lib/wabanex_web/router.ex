defmodule WabanexWeb.Router do
  use WabanexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WabanexWeb do
    pipe_through :api

    get "/", IMCController, :index
  end

  scope "/api" do
    pipe_through :api

    # clients externos consumir a API
    forward "/graphql", Absinthe.Plug, schema: WabanexWeb.Schema
    # tem client de GraphQl interno para testar tudo que tá fazendo
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: WabanexWeb.Schema
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: WabanexWeb.Telemetry
    end
  end
end
