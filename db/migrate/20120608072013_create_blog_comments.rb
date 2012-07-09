class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :mcms_blog_comments do |t|
      t.integer :blog_post_id
      t.boolean :spam
      t.string :name
      t.string :email
      t.text   :body
      t.string :state
      
      t.timestamps
    end
  end
end
