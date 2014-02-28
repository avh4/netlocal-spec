require 'spec_helper'

describe 'resetting all stubs' do
  before do
    HTTParty.post('http://localhost:9999/stubs',
                  headers: {
                    'X-NETLOCAL-PORT' => '8765',
                    'X-NETLOCAL-PATH' => '/index.html',
                  'X-NETLOCAL-RESPONSE-CODE' => '202' },
                  body: '<html>HELLO!</html>')
    HTTParty.delete('http://localhost:9999/stubs')
  end

  it 'stops listening on stubbed ports' do
    expect { HTTParty.get('http://localhost:8765') }.to raise_error(Errno::ECONNREFUSED)
  end
end
