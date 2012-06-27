namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name: "Tung Dao",
                       email: "me@tungdao.com",
                       password: "s3cr3t",
                       password_confirmation: "s3cr3t")
  admin.toggle!(:admin)

  password  = "password"
  30.times do |n|
    name  = Faker::Name.name
    email = Faker::Internet.email
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  30.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user = User.first
  followed_users = users[2..15]
  followers = users[3..10]

  followed_users.each {|u| user.follow!(u) }
  followers.each {|u| u.follow!(user) }
end
