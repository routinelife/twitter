class TweetsController < ApplicationController
    def index
        @tweets = Tweet.all
        render 'tweets/index' # can be omitted
    end

    def create
        token = cookies.signed[:twitter_session_token]
        session = Session.find_by(token: token)
    
        if session
          user = session.user
          @tweet = user.tweets.new(tweet_params)
    
          if @tweet.save
            render 'tweets/create' # can be omitted
          else
            render json: { success: false }
          end
        else
          render json: { success: false }
        end
      end

      private

      def tweet_params
        params.require(:tweet).permit(:message, :user_id)
      end
end
