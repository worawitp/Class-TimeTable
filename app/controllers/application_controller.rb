# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  # You can move this into a different controller, if you wish.  This module gives you the require_role helpers, and others.
  include RoleRequirementSystem

  # for SSL connection
  include SslRequirement

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  # Return true if a parameter corresponding to the given symbol was posted.
  def param_posted?(sym)
    request.post? and params[sym]
  end


  def ssl_required?
    return false if RAILS_ENV == 'development' || RAILS_ENV == 'test'
    super
  end

end
