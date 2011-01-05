#CSIM setting
#ActionMailer::Base.smtp_settings = {
#  :address  => "mail.cs.ait.ac.th",
#  :port  => 25,
#  :domain  => "cs.ait.ac.th"
#}

#Gmail setting
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'cs.ait.ac.th',
  :authentication => :plain,
  :user_name => 'web9.wae',
  :password => 'waeAITweb9'
}