require 'socket'

server = TCPServer.new 9998
Thread.new {
  loop do
    Thread.start(server.accept) do |client|
      client.close
    end
  end
}
