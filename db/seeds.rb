User.create!(name:  "Example User",
email: "furrealfriends@hotmail.com",
password:              "foobaration",
password_confirmation: "foobaration",
admin: true)

99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@ff.com"
password = "password"
User.create!(name:  name,
  email: email,
  password:              password,
  password_confirmation: password)
end
