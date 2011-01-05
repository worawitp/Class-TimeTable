# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  ssl_required :new, :create

  #ssl_required :login, :register

  # render new.erb.html
  def new
  end

  def create
    logout_keeping_session!
    if params[:session]
      @login = params[:session][:login]
      @remember_me = params[:session][:remember_me]
      password = params[:session][:password]
      user = User.authenticate(@login, password)
      if user
        # Protects against session fixation attacks, causes request forgery
        # protection if user resubmits an earlier form using back
        # button. Uncomment if you understand the tradeoffs.
        # reset_session
        self.current_user = user
        session[:user]=user
        new_cookie_flag = (params[:remember_me] == "1")
        handle_remember_cookie! new_cookie_flag
        redirect_back_or_default(:controller => "home", :action => "index")
        flash[:notice] = "Logged in successfully"
      else
        note_failed_signin
        @login       = params[:login]
        @remember_me = params[:remember_me]
        render :action => 'new'
      end
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => "sessions", :action => "new")
  end
  
  def forget_password
      logout_keeping_session!
      if params[:user]
        @user = User.find_by_email(params[:user][:email])
        if @user!=nil
          #temp_user=@user
          #temp_user.password="1234567890"
          if @user.reset_password
            redirect_back_or_default(:controller => "sessions", :action => "new")
            flash[:notice] = "We're sending you an email with your new password"
            logger.info "Sending new password of user : #{@user.login} (#{@user.email})."
            smtp_result = UserMailer.deliver_reset_password_email( @user )
            #logger.info "SMTP result: " + smtp_result.inspect

            #flash[:notice] = "User password updated."
            #redirect_to :action => "index"
          else
            flash[:notice] = "Unable to reset password."
          end
        else
          flash[:error]  = "We couldn't find your e-mail address in our database, sorry.  Please try again, or contact an admin."
          render :action => 'forget_password'
        end
      end
    end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:session][:login]}'"
    logger.warn "Failed login for '#{params[:session][:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
