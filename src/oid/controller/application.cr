module Oid
  module Controller
    module Application
      include Oid::Controller

      @[JSON::Field(ignore: true)]
      getter contexts : ::Contexts

      abstract def init_application(contexts, entity, config_service : Oid::Service::Config)

      # Window initialization and screens management
      # NOTE: Load resources (textures, fonts, audio) after Window initialization
      abstract def init(&block)

      # Update
      abstract def update(&block)

      # Draw
      abstract def draw(&block)

      # Draw UI
      abstract def draw_ui(&block)

      # De-Initialization
      # NOTE: Unload any loaded resources (texture, fonts, audio)
      abstract def cleanup(&block)

      # Close window and OpenGL context
      abstract def exit(&block)
    end
  end
end
