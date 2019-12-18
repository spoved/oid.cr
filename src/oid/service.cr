require "entitas"

module Oid
  module Service
    include JSON::Serializable
  end
end

require "./service/*"

macro register_services
  module ::Oid
    {% services = Oid::Service.constants %}
    class Services
      {% for service in services %}
          getter {{service.stringify.downcase.id}} : Oid::Service::{{service.id}}?
      {% end %} # end for service in services

      def initialize(
      {% for service in services %}
          @{{service.stringify.downcase.id}} : Oid::Service::{{service.id}}? = nil,
      {% end %} # end for service in services
      ); end
    end

    {% for service in services %}
      {% service_name = service.stringify.downcase %}
      @[Component::Unique]
      @[Context(Meta)]
      class {{service.id}}Service < Entitas::Component
        prop :instance, Oid::Service::{{service.id}}, not_nil: true
      end

      class Register{{service.id}}ServiceSystem
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
    {% end %} # end for service in services


    class ServiceRegistrationSystems < Entitas::Feature
      def initialize(contexts : Contexts, services : Oid::Services)
        @name = "OidServiceRegistrationSystems"

        {% for service in services %}
          {% service_name = service.stringify.downcase %}
          unless services.{{service_name.id}}.nil?
            add(
              ::Oid::Register{{service.id}}ServiceSystem.new(
                contexts,
                services.{{service_name.id}}.as(Oid::Service::{{service.id}})
              )
            )
          end
        {% end %} # end for service in services
      end
    end

    module Services::Helper
      abstract def contexts : Contexts
      {% for service in services %}
        {% service_name = service.stringify.downcase %}
        def {{service_name.id}}_service : Oid::Service::{{service.id}}
          self.contexts.meta.{{service_name.id}}_service.instance
        end
      {% end %}
    end
  end
end

register_services
