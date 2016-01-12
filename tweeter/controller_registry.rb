module Tweeter
  class ControllerRegistry
      def initialize()
          @controllers = {}
      end
      
      def add_controller(controller_hash)
          @controllers.merge! controller_hash
      end
      
      def get_controller(name)
          @controllers[name]
      end
  end
end