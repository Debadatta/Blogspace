=begin
	@Name: Blog controller
	@Use:  Creating , modifying, deleting blogs for the cms
	@Created date: 08-06-2012
	@Modified Date: 12-06-2012
  @Company : Mindfire Solutions
=end
class BlogController < ApplicationController

  #Helper files added
  helper :blog

  #before filter added functionalities
  before_filter :find_page, :find_all_blog_categories

  #protected methods start here
protected

  #find_page 
  def find_page
    #@page = Page.find_by_link_url("/blog")
  end

  #method for retrieving all blog categories
  def find_all_blog_categories
    @blog_categories = BlogCategory.all
  end

  
  
end
