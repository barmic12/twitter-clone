task import_posts_with_tags: :environment do
  p 'hello'
  csv_text = File.read('posts.csv')
  csv = CSV.parse(csv_text)
  items = []
  csv.each do |row|
    hash = { body: row[0], user_id: row[1], tags: row[2].split(',') }
    items << hash
  end
  Post.import(items)
end
