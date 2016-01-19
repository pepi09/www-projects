class BaseApplication
  def self.call(env)
    new(env).response
  end

  def initialize(env)
    @env = env
    @router = Router.new
    define_routes
  end

  def response
    Rack::Response.new(
      @router.resolve_request_path(@env['REQUEST_METHOD'].downcase.to_sym, @env['REQUEST_PATH']) || 'Not Found'
    )
  end

  def root_path
    Dir.pwd
  end

  private

  def define_routes
    Routes.define(@router)
  end
end
