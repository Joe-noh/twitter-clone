
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

Fabricator(:michael, :from => :user) do
  name 'Michael'
  self_introduction ''
  digest 'hashed'
  salt 'browns potato'
end

# Statuses
Fabricator(:status_01, :from => :status) do
  text 'Come and dance with me.'
end

Fabricator(:status_02, :from => :status) do
  text 'I found a new way.'
end

Fabricator(:status_03, :from => :status) do
  text 'You know what I mean.'
end