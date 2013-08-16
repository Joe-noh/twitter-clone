
# Users
Fabricator(:john, :from => :user) do
  name 'john'
  self_introduction 'Hello, I am John.'
  digest 'pass'
  salt 'salt'
end

Fabricator(:bob, :from => :user) do
  name 'bob'
  self_introduction nil
  salt = SCrypt::Engine.generate_salt
  digest SCrypt::Engine.hash_secret('bobpassword', salt)
  salt salt
end

# Statuses
Fabricator(:status) do
  text 'So sleepy.'
end
