# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_timetable_session',
  :secret      => '2c1552a9327225bfb6ce3948142a0ee0f283e7550d145b5f3086d13e006bd3d2275b8f2223348fc1003111438ccdec8826146dd1dc06a0370eba01f41bf97d04'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
