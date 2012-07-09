=begin
	@Name: Admin BlogPosts controller
	@Use:  Creating , modifying, deleting blog posts for the cms
	@Created date: 08-06-2012
	@Modified Date: 12-06-2012
  @Company:  Mindfire Solutions
=end
require 'will_paginate/array'
class Admin::Blog::PostsController < ::ApplicationController
  #include will_paginate
  #

  #Including javascripts and css files as per the controller method basis
  before_filter :load_js

  #Crudify method used for a normal crud methods by crudify gem
  #It creates new, create, edit, update, delete, show methods for blog post
  crudify :blog_post,
          :title_attribute => :title,
          :order => 'published_at DESC'


  #Calling before filter for find all categories assign @blog categories
  before_filter :find_all_categories,
                :only => [:new, :edit, :create, :update]

  

  #Assigning a layout admin for admin side controller
  layout 'admin'
  #create method for creating blogbosts
  #parameters: title, body, cached_slug
  def create
    # if the position field exists, set this object as last object, given the conditions of this class.

    #Creating BlogPost model object with the params blog_post
    @blog_post = BlogPost.new(params[:blog_post])

    
    @blog_post.body = params[:blog_post][:body]                  #assigning params[:content] as blog_post body
    @blog_post.cached_slug = params[:blog_post][:cached_slug]          #assigning params[:content1] as blog_post cached_slug

    
    if @blog_post.save
      redirect_to admin_blog_root_path
    else
      render new_admin_blog_post_path
    end
  end

  #assigning all uncategorized blog posts to @blog_posts
  def uncategorized
    @blog_posts = BlogPost.uncategorized.paginate({
      :page => params[:page],
      :per_page => BlogPost.per_page
    })
  render 'index'
  end
  
  protected           #protected methods started from here

  #assigning all blog categories as @blog_categories
  def find_all_categories
    @blog_categories = BlogCategory.find(:all)
  end

  #initailizing the array of javascript and css files by Asset manger for including in page
  def load_js
    AssetManager.include_contrib_library [:core_ui, :jquery_tab]
    AssetManager.include_local_library [:posts, 'ckeditor/init']

    AssetManager.include_css [:blog_global, :submenu]
  end
  
end
