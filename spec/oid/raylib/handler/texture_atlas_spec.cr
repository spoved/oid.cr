require "../../../spec_helper"
require "../../../../src/raylib/handler/texture_atlas.cr"

struct RayLib::Texture2D; end

class TestTextureAtlas
  include RayLib::Handler::TextureAtlas
  getter textures : Hash(String, RayLib::Texture2D) = Hash(String, RayLib::Texture2D).new

  def _load_xml_atlas(name : String, filepath : String) : String
    texture_atlases[name] = Hash(String, AtlasSubTexture).new
    load_xml_atlas(name, filepath)
  end
  def _load_json_atlas(name : String, filepath : String) : String
    texture_atlases[name] = Hash(String, AtlasSubTexture).new
    load_json_atlas(name, filepath)
  end
  def _load_rtpa_atlas(name : String, filepath : String) : String
    texture_atlases[name] = Hash(String, AtlasSubTexture).new
    load_rtpa_atlas(name, filepath)
  end
end

describe RayLib::Handler::TextureAtlas do
  describe "xml" do
    it "can parse file" do
      handler = TestTextureAtlas.new
      path = "examples/assets/atlas/pieces.xml"

      filepath = handler._load_xml_atlas("test_xml", path)
      filepath.should eq "examples/assets/atlas/pieces.png"
      handler.texture_atlases["test_xml"].size.should eq 7
    end
  end

  describe "json" do
    it "can parse file" do
      handler = TestTextureAtlas.new
      path = "examples/assets/atlas/pieces.json"

      filepath = handler._load_json_atlas("test_json", path)
      filepath.should eq "examples/assets/atlas/pieces.png"
      handler.texture_atlases["test_json"].size.should eq 7
    end
  end

  describe "rtpa" do
    it "can parse file" do
      handler = TestTextureAtlas.new
      path = "examples/assets/atlas/pieces.rtpa"

      filepath = handler._load_rtpa_atlas("test_rtpa", path)
      filepath.should eq "examples/assets/atlas/pieces.png"

      handler.texture_atlases["test_rtpa"].size.should eq 7
    end
  end
end
