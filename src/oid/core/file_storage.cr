require "baked_file_system"

module Oid
  class FileStorage
    extend BakedFileSystem

    macro bake_folder(dir)
        bake_folder {{dir}}
    end
  end
end
