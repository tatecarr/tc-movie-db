# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tc-movie-db_session',
  :secret      => 'ae57a750d321b38e3ff301521c04587be6ae0565d12f744178ef2708faed2a5b150111509866b60aa41019a2e5cb2d749d03ba69ce44232779ca7e81191f3886'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
