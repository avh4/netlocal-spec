require 'spec_helper'

describe 'stubbing GET requests' do
  before do
    HTTParty.post('http://localhost:9999/http/8765/get/index.html',
                  headers: { 'X-NETLOCAL-RESPONSE-CODE' => '202',
                             'Content-Type' => 'application/x-netlocal-test' },
                  body: '<html>HELLO!</html>')
    HTTParty.post('http://localhost:9999/http/8765/get/default_response')
  end

  it 'serves HTTP on the requested port' do
    HTTParty.get('http://localhost:8765')
  end

  describe 'stubbing a request' do
    before do
      @response = HTTParty.get('http://localhost:8765/index.html')
    end

    it 'returns the provided response code' do
      @response.code.should == 202
    end

    it 'returns the provided body' do
      @response.body.should == '<html>HELLO!</html>'
    end

    it 'returns the stubbed content type' do
      @response.headers['content-type'].should == 'application/x-netlocal-test'
    end
  end

  describe 'stubbing a request with no specified response code' do
    before do
      @response = HTTParty.get('http://localhost:8765/default_response')
    end

    it 'returns 200 OK' do
      @response.code.should == 200
    end
  end

  describe 'stubbing the same request twice' do
    before do
      HTTParty.post('http://localhost:9999/http/8765/get/index.html',
                    headers: { 'X-NETLOCAL-RESPONSE-CODE' => '202' },
                    body: '<html>GOODBYE!</html>')
    end

    it 'serves the most recent stubbed response' do
      response = HTTParty.get('http://localhost:8765/index.html')
      response.body.should == '<html>GOODBYE!</html>'
    end
  end
end
