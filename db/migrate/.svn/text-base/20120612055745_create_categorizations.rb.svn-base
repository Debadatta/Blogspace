class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :mcms_blog_categories_blog_posts do |t|
      t.references :blog_category
      t.references :blog_post
      t.timestamps
    end
  end
end
