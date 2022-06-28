require "./entity_helper"

module Oid::Systems::StageHelper
  include Oid::Systems::EntityHelper

  abstract def contexts

  def context
    contexts.stage
  end
end
