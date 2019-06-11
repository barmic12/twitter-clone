namespace :export do
  desc 'Export users'
  task :users, [:number] => [:environment] do |task, args|

    CSV.open('users.csv', 'w') do |csv|
      args[:number].to_i.times do
        username = Faker::Internet.username
        email = Faker::Internet.email
        password = Faker::Internet.password
        csv << [username, email, password]
      end
    end
  end

  desc 'Export posts'
  task :posts, %i[posts_number users_number] => [:environment] do |task, args|
    posts_number = args[:posts_number].to_i
    users_number = args[:users_number].to_i
    CSV.open('posts.csv', 'w') do |csv|
      posts_number.times do
        body = Faker::Lorem.sentence(10)
        author_id = rand(1..users_number)
        csv << [body, author_id]
      end
    end
  end

  desc 'Export tags'
  task :tags, [:tags_number] => [:environment] do |task, args|
    tags_number = args[:tags_number].to_i
    tags = Faker::Lorem.unique.words(tags_number)

    CSV.open('tags.csv', 'w') do |csv|
      tags.each_with_index do |tag, idx|
        csv << ["Tag#{idx+1}"]
      end
    end
  end

  desc 'Export taggings'
  task :taggings, [:tags_related] => :environment do |task, args|
    tags_related = args[:tags_related].to_i
    tags = ActsAsTaggableOn::Tag.all
    posts = Post.all
    CSV.open('taggings.csv', 'w') do |csv|
      posts.each do |post|
        tags.sample(tags_related).each do |tag|
          csv << [tag.id, 'Post', post.id, 'tags']
        end
      end
    end
  end

  desc 'Export followers'
  task :followers, %i[n_users_to_following users_number] => :environment do |task, args|
    n_users_to_following = args[:n_users_to_following].to_i
    users = *(1..args[:users_number].to_i)

    CSV.open('followers.csv', 'w') do |csv|
      users.each do |user|
        possible_users_to_following = users - [user]
        users_to_following = possible_users_to_following
                             .sample(n_users_to_following)
        users_to_following.each do |following|
          csv << [user, following]
        end
      end
    end
  end

  desc 'Export comments'
  task :comments, %i[posts_number users_number] => :environment do |task, args|
    posts_number = args[:posts_number].to_i
    users_number = args[:users_number].to_i
    CSV.open('comments.csv', 'w') do |csv|
      posts = *(1..posts_number)

      posts.each do |post|
        rand(5).times do
          csv << [Faker::Lorem.sentence(5), rand(1..users_number), post]
        end
      end
    end
  end

  desc 'Export likes'
  task likes: :environment do |task, args|
    CSV.open('likes.csv', 'w') do |csv|
      posts_number = Post.count
      comments_number = Comment.count
      users_number = User.count
      posts = *(1..posts_number)
      comments = *(1..comments_number)

      posts.each do |post|
        rand(5).times do
          csv << [rand(1..users_number), 'Post', post]
        end
      end
      comments.each do |comment|
        rand(5).times do
          csv << [rand(1..users_number), 'Comment', comment]
        end
      end
    end
  end

  task all: :environment do
    start = Time.now
    Rake::Task['export:users'].invoke(100)
    Rake::Task['export:posts'].invoke(100_000, 100)
    Rake::Task['export:followers'].invoke(4, 100)
    Rake::Task['export:comments'].invoke(100_000, 100)
    p "Execution time: #{Time.now - start}"
  end
end
