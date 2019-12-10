require "admiral"
require "../oid/version"

class Oid::Cli < Admiral::Command
  define_help description: "Oid CLI : #{Oid::VERSION}"
  define_version Oid::VERSION

  def run
    puts help
  end
end

require "../oid/cli/*"

Oid::Cli.run
