require 'net/http'
require 'json'
class Log < Sequel::Model
  plugin :timestamps, update_on_create: true

  def after_save
    super
    send_faye
  end

  def send_faye
    return if ENV['FAYE_SERVER'].nil?
    Thread.new {
      message = { channel: '/browser', data: content }
      uri = URI.parse(ENV['FAYE_SERVER'])
      Net::HTTP.post_form(uri, :message => message.to_json)
    }
  end
end
