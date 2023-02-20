class ApplicationController < ActionController::Base
    helper_method :current_user 
   #gives us access to the method on line 9, in our views

    def current_user 
        @current_user ||= User.find_by(session_token: session[:session_token])
    end




end