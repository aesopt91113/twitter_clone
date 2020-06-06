class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  def authenticate_user
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session.nil?
      render json: {
        success: false
      }
    else
      @user = session.user

      if @user.nil?
        render json: "you are not logged in"
      end
    end
  end

end
