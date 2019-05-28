class AddTagsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :tags, :string, array: true, default: []
    add_index :posts, :tags, using: 'gin'
  end
end