require "entitas"

module Oid
  module Service
    include JSON::Serializable
  end
end

require "./services/*"

macro register_services
  {% services = Oid::Service.constants %}

  class ::Services
    {% for service in services %}
    getter {{service.stringify.downcase.id}} : Oid::Service::{{service.id}}?
    {% end %}

    def initialize(
      {% for service in services %}
      @{{service.stringify.downcase.id}} : Oid::Service::{{service.id}}? = nil,
      {% end %}
    ); end
  end

  {% for service in services %}
  {% service_name = service.stringify.downcase %}
  @[Component::Unique]
  @[Context(Meta)]
  class ::{{service.id}}Service < Entitas::Component
    prop :instance, Oid::Service::{{service.id}}
  end

  class ::Register{{service.id}}ServiceSystem
    include Entitas::Systems::InitializeSystem

    private getter context : MetaContext
    private getter service : Oid::Service::{{service.id}}

    def initialize(contexts : Contexts, service : Oid::Service::{{service.id}})
      @context = contexts.meta
      @service = service
    end

    def init
      self.context.replace_{{service_name.id}}_service(instance: @service)
    end
  end
  {% end %}


  class ServiceRegistrationSystems < Entitas::Feature
    def initialize(contexts : Contexts, services : ::Services)
      @name = "ServiceRegistrationSystems"

      {% for service in services %}
      {% service_name = service.stringify.downcase %}
      unless services.{{service_name.id}}.nil?
        add(
          ::Register{{service.id}}ServiceSystem.new(
            contexts,
            services.{{service_name.id}}.as(Oid::Service::{{service.id}})
          )
        )
      end
      {% end %}
    end
  end

end

register_services
