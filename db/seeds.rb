# Generate 100 users
100.times do
  User.create(
    username: Faker::Internet.username,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password1234",
  )
end

# Get all 100 users in the database
users = User.all

# Generate 5 posts for each user, alternating between users
100.times do |i|
  [ 10, 3, 1, 6 ].sample.times do
    Post.create(
      title: Faker::Lorem.sentence(word_count: [ 3, 5, 6 ].sample),
      content: Faker::Lorem.paragraph(sentence_count: [ 100, 10, 500, 1000 ].sample),
      user_id: users[i % users.length].id,  # Alternate between users
      slug: Faker::Internet.slug,
      status: [ "public", "private" ].sample,
    )
  end
end
