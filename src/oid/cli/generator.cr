require "admiral"
require "crinja"
require "spoved/logger"

class Oid::Cli < Admiral::Command
  class Generator < Admiral::Command
    spoved_logger

    property crinja : Crinja = Crinja.new

    define_help description: "Oid project generator"

    define_argument name : String, required: true, description: "Name of your project"
    define_argument path : String, required: true, description: "Path of your project"
    define_flag gfx_backend : String,
      description: "The GFX backend to use [raylib]",
      short: g,
      default: "raylib"
    define_flag template_path : String,
      description: "Path to Oid templates",
      short: t,
      default: "./templates"
    define_flag camera : String,
      description: "Type of game camera [2d|3d]",
      default: "2d"

    def run
      t_path = File.expand_path(flags.template_path)
      p_path = File.expand_path(arguments.path)

      unless File.exists?(t_path)
        logger.error { "Template path #{t_path} does not exist" }
      end

      unless File.exists?(p_path)
        logger.error { "Project path #{p_path} does not exist" }
      end

      crinja.loader = Crinja::Loader::FileSystemLoader.new(t_path)

      options = {
        "name_raw"    => arguments.name,
        "name_module" => arguments.name.camelcase,
        "camera_type" => flags.camera.upcase,
        "camera_3d"   => flags.camera.downcase == "3d" ? true : false,
      }

      case flags.gfx_backend
      when "raylib"
        options["gfx_lib"] = "raylib"
        options["gfx_class"] = "RayLib"
      else
        logger.error { "GFX Backend: #{flags.gfx_backend} not supported" }
        exit(1)
      end

      dirs = ["systems"]

      dirs.each do |d|
        dir = File.join(p_path, d)
        Dir.mkdir(dir) unless Dir.exists?(dir)
      end

      templates = {
        "main.cr"                 => "main.cr.j2",
        "config.cr"               => "config.cr.j2",
        "components.cr"           => "components.cr.j2",
        "systems/input_system.cr" => "systems/input_system.cr.j2",
        "systems/world_system.cr" => "systems/world_system.cr.j2",
      }

      templates.each do |f, t|
        template = crinja.get_template(t)
        File.open(File.join(p_path, f), "w+") do |file|
          file << template.render(options)
        end
      end

      system("crystal tool format #{p_path}")
    end
  end

  register_sub_command gen : Generator,
    description: "Oid project generator"
end
