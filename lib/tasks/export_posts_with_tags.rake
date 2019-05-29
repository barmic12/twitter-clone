task export_posts_with_tags: :environment do
  number_of_users = 20
  number_of_posts = 100_000
  tags = Faker::Lorem.words(200)

  users = User.limit(number_of_users).order('id desc').to_a

  CSV.open('posts.csv', 'w') do |csv|
    number_of_posts.times do
      body = Faker::Lorem.sentence(10)
      author = users[rand(number_of_users-1)]
      tags = tags.sample(5)
      tags_as_string = tags.join(',')
      csv << [body, author.id, tags_as_string]
    end
  end
end
