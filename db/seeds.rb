# Get all users in the database
users = User.take(20)

# Generate 5 posts, alternating between users
10.times do |i|
  Post.create(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph(sentence_count: [ 100, 10, 500, 1000 ].sample),
    user_id: users[i % users.length].id,  # Alternate between users
    slug: Faker::Internet.slug,
    status: [ "public", "private" ].sample,
  )
end
