class SessionsController < ApplicationController
  before_action :get_user_by_session, only: [:destory]

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && BCrypt::Password.new(@user.password) == params[:user][:password]
      session = @user.sessions.create
      cookies.permanent.signed[:twitter_session_token] = {
        value: session.token,
        httponly: true
      }

      render json: {
        success: true
      }
    else
      render json: {
        success: false
      }
    end
  end

  def authenticated
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token) # this token: token is referring to the token line above matching the value of token

    if session
      user = session.user

      render json: {
        authenticated: true,
        username: user.username
      }
    else
      render json: {
        authenticated: false
      }
    end
  end

  def destroy
    session.delete(:user_id)

    @user = nil
    # redirect_to_root_url
  end

  private

  def get_user_by_session
    @session = @user.find_by[username: params[:cookies]]

    if @session.nil?
      render json: {
        error: "cookies not found"
      }
    end
  end
end
