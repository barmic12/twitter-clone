require 'csv'
namespace :import do
  IMPORT_PATH = Rails.root.join('lib','tasks', 'mockup')
  desc 'Import users'
  task users: :environment do
    csv_text = File.read(IMPORT_PATH + 'users.csv')
    csv = CSV.parse(csv_text)
    users = []
    csv.each do |row|
      user = User.new(username: row[0], email: row[1], password: row[2])
      users << user
    end
    User.import(users)
  end

  desc 'Import posts'
  task posts: :environment do
    csv_text = File.read((IMPORT_PATH + 'posts.csv'))
    csv = CSV.parse(csv_text)
    items = []
    csv.each do |row|
      post = Post.new(body: row[0], user_id: row[1])
      items << post
    end

    Post.import items, batch_size: 1000
  end

  desc 'Import tags'
  task tags: :environment do
    csv_text = File.read(IMPORT_PATH + 'tags.csv')
    csv = CSV.parse(csv_text)
    tags = []
    csv.each do |row|
      tag = ActsAsTaggableOn::Tag.new(name: row[0])
      tags << tag
    end
    ActsAsTaggableOn::Tag.import tags, batch_size: 1000
  end

  desc 'Import taggings'
  task taggings: :environment do
    csv_text = File.read(IMPORT_PATH + 'taggings.csv')
    csv = CSV.parse(csv_text)
    csv.each do |row|
      tagging = ActsAsTaggableOn::Tagging.new(tag_id: row[0], taggable_type: row[1],
                                              taggable_id: row[2], context: row[3])
      tagging.save
    end
  end

  desc 'Import followers'
  task followers: :environment do
    csv_text = File.read((IMPORT_PATH + 'followers.csv'))
    csv = CSV.parse(csv_text)
    items = []
    csv.each do |row|
      follower = Follow.new(follower_id: row[0], following_id: row[1])
      items << follower
    end
    Follow.import items, batch_size: 1000
  end

  desc 'Import comments'
  task comments: :environment do
    csv_text = File.read(IMPORT_PATH + 'comments.csv')
    csv = CSV.parse(csv_text)
    items = []
    csv.each do |csv|
      items << Comment.new(body: csv[0], user_id: csv[1], post_id: csv[2])
    end
    Comment.import items, batch_size: 1000
  end

  desc 'Import likes'
  task likes: :environment do
    csv_text = File.read(IMPORT_PATH + 'likes.csv')
    csv = CSV.parse(csv_text)
    items = []
    csv.each do |row|
      items << Like.new(user_id: row[0], likeable_type: row[1], likeable_id: row[2])
    end
    Like.import items, batch_size: 1000
  end

  desc 'Import all'
  task :all, :environment do
    start = Time.now
    Rake::Task['import:users'].invoke
    Rake::Task['import:posts'].invoke
    Rake::Task['import:followers'].invoke
    Rake::Task['import:comments'].invoke
    Rake::Task['import:likes'].invoke
    p "Execution time: #{Time.now - start}"
  end
end
