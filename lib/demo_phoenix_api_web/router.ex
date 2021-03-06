defmodule DemoPhoenixApiWeb.Router do
  use DemoPhoenixApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DemoPhoenixApiWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit, :delete, :show, :update]
    scope "/users" do
      scope "/:phone_no" do
        get   "/", UserController, :show
        put   "/", UserController, :update
      end
    end
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
      live_dashboard "/dashboard", metrics: DemoPhoenixApiWeb.Telemetry
    end
  end
end
