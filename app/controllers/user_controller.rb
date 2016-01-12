require 'erb'

require './app/models/user'
require './app/repositories/user_repository'

USERS = {
  1 => User.new('foo', 'foo@example.com', 'Foo', 'Yeah', 'Fooland'),
  2 => User.new('bar', 'bar@example.com', 'Bar', 'Yeah', 'Barland'),
  3 => User.new('larodi', 'larodi@example.com', 'Larodi', 'The Great', 'Larodiland'),
  4 => User.new('lorem', 'lorem@example.com', 'Lorem', 'Text', 'Loremland'),
  5 => User.new('ipsum', 'ipsum@example.com', 'Ipsum', 'Text', 'Ipsumland'),
  6 => User.new('xyz', 'xyz@example.com', 'Xyz', 'abc', 'Xyzland'),
}

USER_FOLLOWERS = {
  1 => [2, 3, 5],
}

USER_FOLLOWING = {
  1 => [2, 4, 5, 6]
}

class UserController
  def get_show(query_hash, post_hash)
    id = query_hash['id'] || 1
    @user = UserRepository.find(id)
    render :show
  end

  def get_followers(query_hash, post_hash)
    id = query_hash['id'] || 1
    @user = UserRepository.find(id)
    @followers = UserRepository.followers(id)
    render :followers
  end

  def get_following(query_hash, post_hash)
    id = query_hash['id'] || 1
    @user = UserRepository.find(id)
    @following = UserRepository.following(id)
    render :following
  end
  
  def get_register(query_hash, post_hash)
    render :register
  end
  
  def post_register(query_hash, post_hash)
    p post_hash
    user = User.new(post_hash['username'], post_hash['email'], post_hash['first_name'], post_hash['last_name'], nil)
    UserRepository.create(user)
  end

  private

  def params
    {id: 1}
  end

  def render(view_path)
    view_content = File.read("./app/views/#{view_path}.html.erb")
    ERB.new(view_content).result(binding)
  end
end
