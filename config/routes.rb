module Routes
  def self.define(router)
    router.add_route :get, '/users/:id', to: 'users_controller#show'
  end
end
