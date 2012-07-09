=begin
	@Name: Admin Blog Categories controller
	@Purpose:  Creating , modifying, deleting blog posts for the cms
	@Created date: 08-06-2012
	@Modified Date: 09-06-2012
  @Company  : Mindfire Solutions
=end
class Admin::Blog::CategoriesController < ::ApplicationController

  #Assigning a layout admin for admin side controller
  layout 'admin'
  
  #calling load_assets method before all method to include css and javascript files
  before_filter :load_assets1
  
  #Crudify method used for a normal crud methods by crudify gem
  #It creates new, create, edit, update, delete, show methods for blog category
  crudify :blog_category,
          :title_attribute => :title,
          :order => 'title ASC'

  
  #Create method for creating blog category
  #parameters: title
  
  def create
    @blog_category = BlogCategory.new(params[:blog_category])         #Creating BlogCategory model object with the params blog_post

    if @blog_category.save
      redirect_to admin_blog_categories_path
    else
      render new_admin_blog_category_path
    end
  end

  protected

  #include css and javascript files to AssetManager class global array
  def load_assets1
    AssetManager.include_css [:blog_global, :submenu]
  end

  
end
