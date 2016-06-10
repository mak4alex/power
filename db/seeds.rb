11.times do |i|
  User.create!(
    name:                  "user#{i}@example.com",
    email:                 "user#{i}@example.com",
    password:              "user#{i}@example.com",
    password_confirmation: "user#{i}@example.com"
  )
end


55.times do |i|
  Post.create!(
    title: Faker::Lorem.words.join(" "), 
    body:  Faker::Lorem.paragraph(10)
  )
end
