require 'spec_helper'

describe 'netlocal' do
  it 'listens on the control port' do
    HTTParty.get('http://localhost:9999')
  end
end

