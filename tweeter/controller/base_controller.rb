module Tweeter
    class BaseController
        def render(view_path)
            view_content = File.read("./app/views/#{view_path}.html.erb")
            Rack::Response.new  ERB.new(view_content).result(binding)
        end
  
        def redirect(path)
            response = Rack::Response.new()
            response.redirect(path)
            response.finish
        end
        
        def authorized?(req)
            !req.session['user_id'].nil?
        end
    end
end