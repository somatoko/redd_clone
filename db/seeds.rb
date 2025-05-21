# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

bart = User.create!({
  email: 'bart@example.com',
  password: 'pass12',
  password_confirmation: 'pass12',
  username: 'bart_s',
  admin: true,
})

lisa = User.create!({
  email: 'lisa@example.com',
  password: 'pass12',
  password_confirmation: 'pass12',
  username: 'lisa_s',
  # admin: false,
})

community1 = Community.create!(
  name: 'webdesign',
  title: 'Web Desidgn',
  description: 'All things web desidgn',
  user_id: bart.id,
)

community2 = Community.create!(
  name: 'rails',
  title: 'Railf',
  description: 'All things Ruby on Rails',
  user_id: bart.id,
)

community3 = Community.create!(
  name: 'ruby',
  title: 'Ruby',
  description: 'All things ruby',
  user_id: bart.id,
)

20.times do
  subm1 = Submission.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    body: Faker::Lorem.paragraph,
    # community_id: community2.id,
    community: [community1, community2, community3].sample,
    user: [bart, lisa].sample,
  )
  puts "Submission #{submission.id} created"
end