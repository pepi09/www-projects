# config.ru
require 'rack'
require './application'
require './config/routes'

use Rack::Static, urls: ['/css', '/images'], root: 'app/assets'
run Application
