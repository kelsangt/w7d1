class SessionsController < ApplicationController
    def new
        render :new 
    end

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if @user 
            login(@user)
            new_session_token = @user.reset_session_token!
            session[:session_token] = new_session_token
            redirect_to cats_url()
            #Come back to this later!
        else 
            render :new 
        end
    end
end