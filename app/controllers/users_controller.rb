require 'erb'

class UsersController < BaseController
  def show
    @user = UsersRepository.find(params[:id])
    render :show
  end

  def followers
    @followers = UsersRepository.followers(params[:id])
    render :followers
  end

  def following
    @following = UsersRepository.following(params[:id])
    render :following
  end
end
