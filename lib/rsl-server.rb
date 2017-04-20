require "rsl-server/version"
require "rsl-server/daemon"
require 'eventmachine'
require 'dotenv'
require 'sequel'

Dotenv.load

require 'sequel/connection_pool/threaded'

DB = Sequel.connect(ENV['DATABASE_URL'])
DB.extension(:connection_validator)
DB.pool.connection_validation_timeout = -1

require "rsl-server/models/log"

module RslServer
  IP = "0.0.0.0"
  PORT = 41346

  class EchoServer < EM::Connection
    def receive_data(data)
      Log.create(content: data)
    end
  end

  class Socket
    attr_accessor :socket

    def run!(daemon)
      until daemon.quit?
        start
      end
    end

    def initialize

    end

    def start
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
