# config.ru
require 'rack'
require './app/controllers/user_controller'
require './tweeter/controller_registry'
require './tweeter/router'

module Tweeter
  class Application
    def call(env)
      controller = ::UserController.new
      query_string = env['QUERY_STRING']
      query_hash = split_query(query_string)
      
      
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
        post_hash = split_query(env['rack.input'].gets)
        user = User.new(post_hash['username'], post_hash['email'], post_hash['first_name'], post_hash['last_name'], nil)
        Rack::Response.new UserRepository.create(user)
      when '/register'
        Rack::Response.new controller.register
      else
        Rack::Response.new "Page not found!", 404
      end
    end
    
    def split_query(query_string)
      query_string.split('&').map do |query|
        split_array = query.split '='
        if split_array.count == 1
          split_array << nil
        end
        
        split_array
      end.to_h
    end
  end
end

use Rack::Static, :urls => ["/css", "/images"], :root => "app/views"
# run Tweeter::Application

use Rack::Session::Pool

controller_registry = Tweeter::ControllerRegistry.new
controller_registry.add_controller 'user' => UserController.new
myapp = Tweeter::Router.new controller_registry

sessioned = Rack::Session::Pool.new(myapp,
  #:domain => '0.0.0.0',
  :expire_after => 2592000
)

run sessioned