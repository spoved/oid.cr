class RayLib::LoggerService
  include Oid::Service::Logger

  def level=(value : ::Logger::Severity)
    RayLib.set_trace_log_level(convert_log_level(value))
  end

  def log(msg : String, level : ::Logger::Severity = ::Logger::INFO)
    RayLib.trace_log(convert_log_level(level), msg)
  end

  private def convert_log_level(level : ::Logger::Severity)
    case level
    when ::Logger::DEBUG
      RayLib::Enum::TraceLog::Debug.value
    when ::Logger::INFO
      RayLib::Enum::TraceLog::Info.value
    when ::Logger::WARN
      RayLib::Enum::TraceLog::Warning.value
    when ::Logger::ERROR
      RayLib::Enum::TraceLog::Error.value
    else
      RayLib::Enum::TraceLog::Info.value
    end
  end
end
