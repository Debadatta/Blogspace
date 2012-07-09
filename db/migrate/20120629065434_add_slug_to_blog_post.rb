class AddSlugToBlogPost < ActiveRecord::Migration
  def change
    add_column :mcms_blog_posts, :slug, :string
    add_index :mcms_blog_posts, :slug, :unique => true
  end
end
