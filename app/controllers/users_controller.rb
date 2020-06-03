class UsersController < ApplicationController
  # create a new user based on given parameters
  def create
    @user = User.new(user_params)

    if @user.save
      render json: {
        user: {
          id: @user.id,
          username: @user.username,
          email: @user.email,
        }
      }
    else
      render json: {
        errors: @user.errors.messages
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :username, :email)
  end
end
