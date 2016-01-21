module Tweeter
    class LoginController < BaseController
        def get_login(req)
            render :login
        end
  
        def post_login(req)
            if user = UserRepository.find_by_username(req.params['username'])
                req.session['user_id'] = user.id
                redirect '/show'
            else
                redirect '/login'
            end
        end
        
        def get_logout(req)
            req.session.clear
            redirect '/show'
        end
    end
end