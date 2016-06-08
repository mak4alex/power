44.times do |i|
  Post.create!(
    title: Faker::Lorem.words.join(' '), 
    body:  Faker::Lorem.paragraph(10)
  )
end
