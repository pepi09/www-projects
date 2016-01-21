module Tweeter
  class Router
      def initialize(controller_registry, routes)
          @routes = routes
          @controller_registry = controller_registry
      end
      
      def call(env)
        req = Rack::Request.new env
        request_method = req.request_method.downcase.to_sym
        
        if (req_mapping = @routes[request_method][req.path_info])
          controller_mapping = controller_action(request_method.to_s, req_mapping)
          controller = @controller_registry.get_controller controller_mapping[:controller]
          controller.send(controller_mapping[:action], req)
        else
          Rack::Response.new('Not found', 404)
        end
      end
      
      def controller_action(request_method, mapping)
        controller, action = mapping.split('#')
        { controller: controller, action: "#{request_method}_#{action}" }
      end
  end
end