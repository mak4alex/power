44.times do |i|
  Post.create!(
    title: Faker::Lorem.sentence(3), 
    body:  Faker::Lorem.paragraph(10)
  )
end
