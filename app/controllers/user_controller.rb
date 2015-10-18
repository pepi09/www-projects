require 'erb'

require './models/user'

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
  def show
    @user = USERS[params[:id]]
    render :show
  end

  def followers
    @followers = USER_FOLLOWERS[params[:id]].map { |follower_id| USERS[follower_id] }
    render :followers
  end

  def following
    @following = USER_FOLLOWING[params[:id]].map { |following_id| USERS[following_id] }
    render :following
  end

  private

  def params
    {id: 1}
  end

  def render(view_path)
    view_content = File.read("./views/#{view_path}.html.erb")
    ERB.new(view_content).result(binding)
  end
end
