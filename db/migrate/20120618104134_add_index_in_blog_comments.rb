class AddIndexInBlogComments < ActiveRecord::Migration
  def change
    add_index :mcms_blog_comments, :state
  end
end
