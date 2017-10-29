User.create!(name:  "Example User",
             email: "furrealfriends@hotmail.com",
             password:              "foobaration",
             password_confirmation: "foobaration",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@ff.com"
password = "password"
User.create!(name: name,
            email: email,
            password:              password,
            password_confirmation: password,
            activated: true,
            activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  category = "Technical"
  title = Faker::Lorem.sentence(1)
  message = Faker::Lorem.sentence(4)
  status = "Open"
  users.each { |user| user.tickets.create!(category: category,
                                           title: title,
                                           message: message,
                                           status: status
                                           ) }
end
