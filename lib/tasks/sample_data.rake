namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
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

    users = User.all(limit: 6)
    30.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end
