require "rsl-server/version"
require "rsl-server/cli"
require 'eventmachine'

module RslServer
  IP = "0.0.0.0"
  PORT = 41346

  class EchoServer < EM::Connection
    def receive_data(data)
      p "d" + data
    end
  end

  class Socket
    attr_accessor :socket

    def initialize
      EventMachine::run do
        Signal.trap("INT")  { EventMachine.stop }
        Signal.trap("TERM") { EventMachine.stop }

        @socket = EM::open_datagram_socket RslServer::IP,
                                           RslServer::PORT,
                                           RslServer::EchoServer

        p "Started EchoServer on #{RslServer::IP}:#{RslServer::PORT}..."
      end
    end
  end
end
