class UserMailer < ActionMailer::Base
  WWW_ADDR = "web9.cs.ait.ac.th/timetable"
  WWW_SITE = "Web9"

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://"+WWW_ADDR+"/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://"+WWW_ADDR+"/"
  end
  
  def reset_password_email(user)
    setup_email(user)
    @subject    += 'This is your new password!'
    #@body[:new_password]  = "abc"
  end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = WWW_SITE
      @subject     = "["+WWW_SITE+"] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
