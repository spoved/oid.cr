require "../../spec_helper"

describe Oid::Service::Logger do
  it "passes the message to implimented service" do
    service = SpecLoggerService.new
    service.log("message")
    service.log_msg.should eq "message"
  end
end
