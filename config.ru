# config.ru
require 'rack'
require './app/controllers/user_controller'
require './tweeter/controller_registry'
require './tweeter/router'

module Tweeter
  class Application
  end
end

ROUTES = {
          get: {
              '/' => 'user#show',
              '/show' => 'user#show',
              '/following' => 'user#following',
              '/followers' => 'user#followers',
              '/register' => 'user#register'
          },
          post: {
            '/register' => 'user#register'  
          },
      }

use Rack::Static, :urls => ["/css", "/images"], :root => "app/views"
# run Tweeter::Application

use Rack::Session::Pool

controller_registry = Tweeter::ControllerRegistry.new
controller_registry.add_controller 'user' => UserController.new
myapp = Tweeter::Router.new controller_registry, ROUTES

sessioned = Rack::Session::Pool.new(myapp,
  #:domain => '0.0.0.0',
  :expire_after => 2592000
)

run sessioned