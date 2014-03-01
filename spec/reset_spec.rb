require 'spec_helper'

describe 'shutting down all mock servers' do
  before do
    HTTParty.post('http://localhost:9999/http/8765/get/index.html',
                  body: '<html>HELLO!</html>')
    HTTParty.delete('http://localhost:9999')
  end

  it 'stops listening on the port' do
    expect { HTTParty.get('http://localhost:8765') }.to raise_error(Errno::ECONNREFUSED)
  end
end
