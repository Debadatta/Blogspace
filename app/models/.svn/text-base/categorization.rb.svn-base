=begin
  @Name    Categorization model
  @Created at :12-06-2012
  @Updated at  :12-06-2012
  @Purpose :Needed for initailizing activerecord for blog_categories_blog_posts table in rails
  @Company  : Mindfire Solutions
=end
class Categorization < ActiveRecord::Base
  
  #Setting table name  
  self.table_name = 'mcms_blog_categories_blog_posts'

  #Defining model associations
  belongs_to :blog_post
  belongs_to :blog_category
end
