
# Users
Fabricator(:john, :from => :user) do
  name 'john'
  self_introduction 'Hello, I am John.'
end

Fabricator(:bob, :from => :user) do
  name 'bob'
  self_introduction 'Hey there.'
end

# Statuses
Fabricator(:status) do
  text 'So sleepy.'
end
