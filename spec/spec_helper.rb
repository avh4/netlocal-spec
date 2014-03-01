require 'httparty'
require 'support/netlocal_is_running'
require 'support/obstruct_port_9998'

RSpec.configure do |config|
  config.before(:each) do
    HTTParty.delete("http://localhost:9999")
  end
end
