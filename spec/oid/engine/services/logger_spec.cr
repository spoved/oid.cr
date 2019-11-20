require "../../../spec_helper"

require "logger"

class SpecLoggerService
  include Oid::Service::Logger
  property log_msg : String? = nil

  def clear
    self.log_msg = nil
  end

  def log(msg : String)
    self.log_msg = msg
  end
end

describe Oid::Service::Logger do
  it "passes the message to implimented service" do
    service = SpecLoggerService.new
    service.log("message")
    service.log_msg.should eq "message"
  end
end
