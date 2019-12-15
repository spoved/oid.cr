macro include_services(*args)
  {% for service in args %}
  {% service_name = service.stringify.downcase %}
  protected setter {{ service_name.id }}_service : Oid::Service::{{service}}? = nil

  def {{ service_name.id }}_service : Oid::Service::{{service}}
    raise "{{service}} service is not set" if @{{ service_name.id }}_service.nil?
    @{{ service_name.id }}_service.as(Oid::Service::{{service}})
  end
  {% end %}

  private def _init_services
    {% for service in args %}
    {% service_name = service.stringify.downcase %}
    @{{ service_name.id }}_service = contexts.meta.{{ service_name.id }}_service.instance
    {% end %}
  end
end
