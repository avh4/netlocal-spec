require 'httparty'
require 'support/netlocal_is_running'

RSpec.configure do |config|
  config.before(:each) do
    HTTParty.delete("http://localhost:9999")
  end
end
