# config.ru
require 'rack'
require 'erb'
require 'sqlite3'
require 'time'


require './tweeter/controller/base_controller'
require './tweeter/controller_registry'
require './tweeter/router'

require './app/models/user'
require './app/repositories/user_repository'
require './app/services/file_service'
require './app/controllers/user_controller'
require './app/controllers/login_controller'
require './app/controllers/upload_controller'

DB = SQLite3::Database.new './db/database.sqlite3'


ROUTES = {
          get: {
              '/' => 'user#show',
              '/show' => 'user#show',
              '/following' => 'user#following',
              '/followers' => 'user#followers',
              '/register' => 'user#register',
              '/login' => 'login#login',
              '/logout' => 'login#logout',
              '/upload' => 'upload#upload',
          },
          post: {
            '/register' => 'user#register',
            '/login' => 'login#login',
            '/upload' => 'upload#upload',
          },
      }

use Rack::Static, :urls => ["/css", "/images", "/uploads"], :root => "app/public"
use Rack::Session::Pool

controller_registry = Tweeter::ControllerRegistry.new
controller_registry.add_controllers('user' => Tweeter::UserController.new(),
                                   'login' => Tweeter::LoginController.new(),
                                   'upload' => Tweeter::UploadController.new())
router = Tweeter::Router.new controller_registry, ROUTES

sessioned = Rack::Session::Pool.new(router,
  #:domain => '0.0.0.0',
  :expire_after => 2592000
)

run sessioned