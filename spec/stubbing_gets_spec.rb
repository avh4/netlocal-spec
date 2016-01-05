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
      expect(@response.code).to eq(202)
    end

    it 'returns the provided body' do
      expect(@response.body).to eq('<html>HELLO!</html>')
    end

    it 'returns the stubbed content type' do
      expect(@response.headers['content-type']).to eq('application/x-netlocal-test')
    end
  end

  describe 'stubbing a request with no specified response code' do
    before do
      @response = HTTParty.get('http://localhost:8765/default_response')
    end

    it 'returns 200 OK' do
      expect(@response.code).to eq(200)
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
      expect(response.body).to eq('<html>GOODBYE!</html>')
    end
  end

  describe 'stubbing a port that is already in use on INADDR_ANY (by another process)' do
    before do
      @response = HTTParty.post('http://localhost:9999/http/9998/get/index.html')
    end

    it 'returns an error' do
      expect(@response.code).to eq(503)
    end
  end

  describe 'stubbing a port that is already in use on localhost (by another process)' do
    before do
      @response = HTTParty.post('http://localhost:9999/http/9997/get/index.html')
    end

    it 'returns an error' do
      expect(@response.code).to eq(503)
    end
  end
end
