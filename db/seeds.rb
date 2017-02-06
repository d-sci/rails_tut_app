# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Users
User.create!(name:  "D-Sci",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now
             )
             
names = ['Sitamop', 'Brown NRG', 'Mux']
3.times do |n|
  name  = names[n-1]
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now
               )
end

# Microposts
users = User.all
facts = []
200.times do
  fact = Faker::ChuckNorris.fact
  facts << fact if fact.length < 138
end

n = facts.length/4
n.times do |i|
  users.each do |user|
    user.microposts.create!(content: facts[i+n*(user.id-1)])
  end
end

# Following relationships
user  = users.first
following = users[1..3]
followers = users[1..3]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
user  = users.second
following = users[2..3]
followers = users[2..2]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }