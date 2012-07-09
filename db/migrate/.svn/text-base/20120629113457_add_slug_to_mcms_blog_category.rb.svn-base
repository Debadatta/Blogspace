class AddSlugToMcmsBlogCategory < ActiveRecord::Migration
  def change
    add_column :mcms_blog_categories, :slug, :string
    add_index :mcms_blog_categories, :slug, :unique => true
  end
end
