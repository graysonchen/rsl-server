require 'sinatra'
require 'faye'
require 'permessage_deflate'
require 'dotenv'
Dotenv.load

class RslServerApp < Sinatra::Base
  use Faye::RackAdapter, :mount => '/faye', :timeout => 25 do |bayeux|
    bayeux.add_websocket_extension(PermessageDeflate)
  end

  get '/' do
    erb :index
  end
end
