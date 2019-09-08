module Entitas
  module EntityLink
    private property _entity : Entitas::IEntity? = nil

    abstract def logger : Logger

    def link(entity : Entitas::IEntity)
      raise Exception.new ("EntityLink is already linked to #{_entity} !") unless _entity.nil?
      self._entity = entity
      self._entity.retain(self)
    end

    def unlink
      raise Exception.new("EntityLink is already unlinked!") if _entity.nil?
      self._entity.release(self)
      self._entity = nil
    end

    def finalize
      unless self._entity.nil?
        logger.warn "EntityLink got destroyed but is still linked to #{self._entity}! " \
                    "Please call #unlink before it is destroyed."
      end
    end
  end
end
