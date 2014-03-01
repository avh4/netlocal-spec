require 'socket'

def start(server)
  Thread.new {
    loop do
      Thread.start(server.accept) do |client|
        client.close
      end
    end
  }
end

start(TCPServer.new 9998)
start(TCPServer.new '127.0.0.1', 9997)
