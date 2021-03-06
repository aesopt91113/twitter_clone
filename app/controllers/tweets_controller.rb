class TweetsController < ApplicationController
  before_action :get_user_by_username, only: [:index_by_user]
  before_action :authenticate_user, only: [:create, :destroy]
  before_action :get_tweet_by_id, only: [:destroy]

  def create
    @tweet = @user.tweets.new(create_params)

    if @tweet.save
      render json: {
        tweet: {
          username: @user.username,
          message: @tweet.message
        }
      }
    else
      render json: {
        errors: @tweet.errors.messages
      }
    end
  end

  def index
    @tweets = Tweet.all.order(created_at: :desc)

    render "tweets/create.json.jbuilder"
  end

  def index_by_user
    @tweets = @user.tweets

    render "tweets/index_by_user.json.jbuilder"
  end

  def destroy
    @tweet.destroy

    render json: {
      success: true
    }
  end

  private

  def get_user_by_username
    @user = User.find_by(username: params[:username])

    if @user.nil?
      render json: {
        message: "no user found"
      }
    end
  end

  def create_params
    params.require(:tweet).permit(:message)
  end

  def get_tweet_by_id
    @tweet = @user.tweets.find_by(id: params[:id])

    if @tweet.nil?
      render json: {
        message: "tweet not found"
      }
    end
  end
end
