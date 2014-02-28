require 'spec_helper'

describe 'netlocal' do
  it 'listens on the control port' do
    HTTParty.get('http://localhost:9999')
  end

  it 'does not listen on other ports until directed to' do
    expect { HTTParty.get('http://localhost:8765') }.to raise_error(Errno::ECONNREFUSED)
  end
end

