# config.ru
require 'rack'
require './app/controllers/user_controller'

module Tweeter
  class Application
    def self.call(env)
      controller = ::UserController.new
      query_string = env['QUERY_STRING']
      query_hash = query_string.split('&').map do |query|
        query.split '='
      end.to_h
      
      if query_hash['id']
        id = query_hash['id']
      else
        id = 1
      end
      
      case env['PATH_INFO']
      when '/'
        Rack::Response.new controller.show id
      when '/show'
        Rack::Response.new controller.show id
      when '/following'
        Rack::Response.new controller.following id
      when '/followers'
        Rack::Response.new controller.followers id
      when '/test'
         Rack::Response.new env
      else
        Rack::Response.new "Page not found!", 404
      end
    end
  end
end

run Tweeter::Application