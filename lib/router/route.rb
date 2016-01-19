class Router
  class Route
    def initialize(request_method, request_path, controller_action)
      @request_method = request_method
      @request_path_pattern = path_to_pattern(request_path)
      @controller, @action = parse_controller_action(controller_action)
    end

    def match?(request_method, request_path)
      @request_method == request_method && @request_path_pattern.match(request_path)
    end

    def resolve(request_path)
      params = extract_params(request_path)
      @controller.new(params: params).public_send(@action)
    end

    private

    def path_to_pattern(path)
      pattern_string = path.
        split('/').
        map { |part| part.start_with?(':') ? "(?<#{part[1..-1]}>[^/]+)" : part }.
        join('/')

      # Regexp.new(pattern_string)
      /^#{pattern_string}$/
    end

    def parse_controller_action(controller_action)
      controller, action = controller_action.split('#')
      controller_class = controller.split('_').map(&:capitalize).join('')

      [Object.const_get(controller_class), action]
    end

    def extract_params(request_path)
      match_data = @request_path_pattern.match(request_path)
      Hash[match_data.names.map(&:to_sym).zip(match_data.captures)]
    end
  end
end
