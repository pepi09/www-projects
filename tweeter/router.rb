module Tweeter
  class Router
      def initialize(controller_registry, routes)
          @routes = routes
          @controller_registry = controller_registry
      end
      
      def call(env)
          post_hash = {}
          query_hash = {}
          if post_data = env['rack.input'].gets
              request_method = :post
              post_hash = split_query(post_data || "")
          else
              request_method = :get
              query_hash = split_query(env['QUERY_STRING'] || "")
          end
          
          if (mapping = @routes[request_method][env['PATH_INFO']])
            controller_and_action = controller_action(request_method.to_s, mapping)
            controller = @controller_registry.get_controller controller_and_action['controller']
            Rack::Response.new controller.send(controller_and_action['action'], query_hash, post_hash)
          else
            Rack::Response.new('Not found', 404)
          end
      end
      
      def controller_action(request_method, mapping)
        controller, action = mapping.split('#')
        { 'controller' => controller, 'action' => "#{request_method}_#{action}" }
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