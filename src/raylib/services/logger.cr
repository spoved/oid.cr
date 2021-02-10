class RayLib::LoggerService
  include Oid::Service::Logger

  def initialize(level : ::Log::Severity = ::Log::Severity::Info)
    self.level = level
  end

  def level=(value : ::Log::Severity)
    RayLib.set_trace_log_level(convert_log_level(value))
  end

  def log(msg : String, level : ::Log::Severity = ::Log::Severity::Info)
    RayLib.trace_log(convert_log_level(level), msg)
  end

  private def convert_log_level(level : ::Log::Severity)
    case level
    when ::Log::Severity::Debug
      RayLib::Enum::TraceLog::Debug.value.to_i
    when ::Log::Severity::Info
      RayLib::Enum::TraceLog::Info.value.to_i
    when ::Log::Severity::Warn
      RayLib::Enum::TraceLog::Warning.value.to_i
    when ::Log::Severity::Error
      RayLib::Enum::TraceLog::Error.value.to_i
    else
      RayLib::Enum::TraceLog::Info.value.to_i
    end
  end
end
