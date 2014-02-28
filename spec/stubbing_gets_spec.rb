require 'spec_helper'

describe 'stubbing GET requests' do
  before do
    HTTParty.post('http://localhost:9999/stubs',
                  headers: {
                    'X-NETLOCAL-PORT' => '8765',
                    'X-NETLOCAL-PATH' => '/index.html',
                  'X-NETLOCAL-RESPONSE-CODE' => '202' },
                  body: '<html>HELLO!</html>')
  end

  it 'serves HTTP on the requested port' do
    HTTParty.get('http://localhost:8765')
  end

  describe 'a request to the stubbed path' do
    before do
      @response = HTTParty.get('http://localhost:8765/index.html')
    end

    it 'returns the provided response code' do
      @response.code.should == 202
    end

    it 'returns the provided body' do
      @response.body.should == '<html>HELLO!</html>'
    end
  end

  describe 'stubbing the same request twice' do
    before do
      HTTParty.post('http://localhost:9999/stubs',
                    headers: {
                      'X-NETLOCAL-PORT' => '8765',
                      'X-NETLOCAL-PATH' => '/index.html',
                    'X-NETLOCAL-RESPONSE-CODE' => '202' },
                    body: '<html>GOODBYE!</html>')
    end

    it 'serves the most recent stubbed response' do
      response = HTTParty.get('http://localhost:8765/index.html')
      response.body.should == '<html>GOODBYE!</html>'
    end
  end
end
