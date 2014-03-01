require 'httparty'
require 'support/netlocal_is_running'
require 'support/obstruct_ports'

RSpec.configure do |config|
  config.before(:each) do
    HTTParty.delete("http://localhost:9999")
  end
end
