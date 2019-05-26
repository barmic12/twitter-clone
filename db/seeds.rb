ApplicationRecord.transaction do
  number_of_users = 10
  number_of_posts = 10
  max_number_of_comments = 10
  max_number_of_likes = 10
  number_of_tags = 100
  max_number_of_tags_per_post = 5
  tag_list = Faker::Lorem.words(number_of_tags)

  users = []
  number_of_users.times do
    users.push(
      User.create(username: Faker::Internet.username,
                  email: Faker::Internet.email,
                  password: Faker::Internet.password))
  end
  number_of_posts.times do
    post_author = users[rand(number_of_users - 1)]
    Post.create(body: Faker::Lorem.sentence(10),
                user: post_author).tap do |post|
      number_of_post_likes = rand(max_number_of_comments)
      number_of_post_likes.times do
        like_author = users[rand(number_of_users - 1)]
        post.likes.create(user: like_author)
      end
      tags_of_post_number = rand(max_number_of_tags_per_post)
      tags_of_post_number.times do
        tags = tag_list.sample(1 + rand(max_number_of_tags_per_post))
        post.tag_list.add(tags)
        post.save
      end

      number_of_comments = rand(max_number_of_comments)
      number_of_comments.times do
        comment_author = users[rand(number_of_users - 1)]
        post.comments.create(body: Faker::Lorem.sentence(7),
                             user: comment_author).tap do |comment|
          number_of_comment_likes = rand(max_number_of_likes)
          number_of_comment_likes.times do
            like_author = users[rand(number_of_users - 1)]
            comment.likes.create(user: like_author)
          end
        end
      end
    end
  end
end
