require "xml"
require "json"

module RayLib
  module Handler
    # Module to handle the parsing and loading of Raylib texture atlases
    module TextureAtlas
      alias AtlasSubTexture = NamedTuple(
        name: String, padding: Float32,
        orig_x: Float32, orig_y: Float32,
        pos_x: Float32, pos_y: Float32,
        width: Float32, height: Float32,
      )

      abstract def textures : Hash(String, RayLib::Texture2D)

      @[JSON::Field(ignore: true)]
      getter texture_atlases : Hash(String, Hash(String, AtlasSubTexture)) = Hash(String, Hash(String, AtlasSubTexture)).new

      def load_texture_atlas(path, name, entity)
        # Atlas already exists
        if textures[name]?
          # Retain it
          texture_links[name].retain(entity)
        else
          filepath = File.join(path, name)
          texture_atlases[name] = Hash(String, AtlasSubTexture).new

          case File.extname(filepath)
          when ".xml"
            img_path = load_xml_atlas(name, filepath)
          when ".json"
            img_path = load_json_atlas(name, filepath)
          when ".rtpa"
            img_path = load_rtpa_atlas(name, filepath)
          else
            raise "Unsupported texture atlas file type: #{File.extname(filepath)}"
          end

          raise "Image file path doesnt exist: #{img_path}" unless File.exists?(img_path)

          # Need to load it
          textures[name] = RayLib.load_texture(img_path)
          # Create the AERC
          texture_links[name] = Entitas::UnsafeAERC.new
          # Then retain it
          texture_links[name].retain(entity)
        end
      end

      # Load RayLib formatted XML
      private def load_xml_atlas(name : String, filepath : String) : String
        document = XML.parse(File.read(filepath))
        raise "Unable to load atlas at #{filepath}" if document.nil?
        atlas = document.first_element_child
        raise "Unable to load atlas at #{filepath}" unless atlas
        raise "Unable to load atlas at #{filepath}" unless atlas.name == "AtlasTexture"

        # Search for all subtextures
        atlas.children.each do |child|
          next unless child.element?
          next unless child.name == "Sprite"

          t_name = child["nameId"]
          texture_atlases[name][t_name] = {
            name:    t_name,
            padding: child["padding"].to_f32,
            orig_x:  child["originX"].to_f32,
            orig_y:  child["originY"].to_f32,
            pos_x:   child["positionX"].to_f32,
            pos_y:   child["positionY"].to_f32,
            width:   child["trimRecWidth"].to_f32,
            height:  child["trimRecHeight"].to_f32,
          }
        end

        File.join(File.dirname(filepath), atlas["imagePath"])
      end

      private def load_json_atlas(name : String, filepath : String) : String
        atlas = JSON.parse(File.read(filepath))
        atlas["sprites"].as_a.each do |child|
          t_name = child["nameId"].as_s
          texture_atlases[name][t_name] = {
            name:    t_name,
            padding: child["padding"].as_i.to_f32,
            orig_x:  child["origin"]["x"].as_i.to_f32,
            orig_y:  child["origin"]["y"].as_i.to_f32,
            pos_x:   child["position"]["x"].as_i.to_f32,
            pos_y:   child["position"]["y"].as_i.to_f32,
            width:   child["trimRec"]["width"].as_i.to_f32,
            height:  child["trimRec"]["height"].as_i.to_f32,
          }
        end
        File.join(File.dirname(filepath), atlas["atlas"]["imagePath"].as_s)
      end

      private def load_rtpa_atlas(name : String, filepath : String) : String
        image_path = ""
        File.read_lines(filepath).each do |line|
          a_match = /^a\s(?<imagePath>.+)\s(?<width>\d+)\s(?<height>\d+)\s(?<spriteCount>\d+)\s(?<isFont>\d+)\s(?<fontSize>\d+)$/.match(line)

          if a_match
            image_path = a_match["imagePath"]
          end

          s_match = /^s (?<nameId>\w+) (?<originX>\d+) (?<originY>\d+) (?<positionX>\d+) (?<positionY>\d+) (?<sourceSizeWidth>\d+) (?<sourceSizeHeight>\d+) (?<padding>\d+) (?<trimmed>\d+) (?<trimRecX>\d+) (?<trimRecY>\d+) (?<trimRecWidth>\d+) (?<trimRecHeight>\d+)$/.match(line)
          if s_match
            t_name = s_match["nameId"]
            texture_atlases[name][t_name] = {
              name:    t_name,
              padding: s_match["padding"].to_f32,
              orig_x:  s_match["originX"].to_f32,
              orig_y:  s_match["originY"].to_f32,
              pos_x:   s_match["positionX"].to_f32,
              pos_y:   s_match["positionY"].to_f32,
              width:   s_match["trimRecWidth"].to_f32,
              height:  s_match["trimRecHeight"].to_f32,
            }
          end
        end

        raise "Unable to parse imagePath" if image_path.empty?
        File.join(File.dirname(filepath), image_path)
      end
    end
  end
end
