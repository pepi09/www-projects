class Router
  def initialize
    @routes = []
  end

  def resolve_request_path(request_method, request_path)
    route = @routes.find { |route| route.match?(request_method, request_path) }
    route.resolve(request_path) if route
  end

  def add_route(request_method, request_path, to:)
    @routes << Route.new(request_method, request_path, to)
  end
end
