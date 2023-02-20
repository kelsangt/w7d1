class ApplicationController < ActionController::Base
    #1 question - how is there a views session 
    #-for log in form


    helper_method :current_user 
   #gives us access to the method on line 9, in our views

    def current_user 
        @current_user ||= User.find_by(session_token: session[:session_token])
               #i dont get this whole thing                          

        #because we're calling it on the class User does that give us access to all the token related methods 
        #we created in the user class 

        #what is the equal sign doing attached to the truthsy/falsey, does it make it a setter?

    end

    



end