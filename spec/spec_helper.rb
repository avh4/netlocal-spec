require 'httparty'

Spec::Runner.configure do |config|
  config.before(:each) do
    HTTParty.delete("http://localhost:9999/stubs")
  end
end
