
# Users
Fabricator(:franz, :from => :user) do
  name 'FranzFerdinand'
  self_introduction "I'm gonna burn this city."
  digest 'pass'
  salt 'salt'
end

Fabricator(:lindsey, :from => :user) do
  name 'LindseyWells'
  self_introduction 'Great western wind catches in my hair.'
  lindsey_salt = SCrypt::Engine.generate_salt
  digest SCrypt::Engine.hash_secret('mysecret', lindsey_salt)
  salt lindsey_salt
end

# Statuses
Fabricator(:status) do
  text 'So sleepy.'
end
