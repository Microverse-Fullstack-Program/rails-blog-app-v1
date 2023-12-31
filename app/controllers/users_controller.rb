class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])

    redirect_to users_path if @user.nil?
  end
end
