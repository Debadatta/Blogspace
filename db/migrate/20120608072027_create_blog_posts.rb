class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :mcms_blog_posts do |t|
      t.string :title
      t.text :body
      t.boolean :draft
      t.datetime :published_at
      t.integer :user_id
      t.text :cached_slug
      t.string :custom_url
      t.string :custom_teaser

      t.timestamps
    end
  end
end
