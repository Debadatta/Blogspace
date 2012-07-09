=begin
  @Name    :BlogCategory model
  @Created at :12-06-2012
  @Updated at  :12-06-2012
  @Purpose :Needed for initailizing activerecord for blog_categories table in rails
  @Company : Mindfire Solutions
=end
class BlogCategory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  #set table name prefix as mcms_
  self.table_name = 'mcms_blog_categories'
  
  #attribute accessibles
  attr_accessible :title

  #validation rules
  validates :title, :presence => true


  #model association rules
  has_many :categorizations
  has_many :posts, :through => :categorizations, :source => :blog_post

  def post_count
    posts.select(&:live?).count
  end
end
