class AddCustomIndexInMcmsBlogPosts < ActiveRecord::Migration
  def change
    add_index :mcms_blog_posts, :user_id
  end
end
