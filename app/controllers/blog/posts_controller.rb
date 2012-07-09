=begin
	Name: Posts controller
	Use:  Creating , modifying, deleting blog posts for the cms
	Created date: 08-06-2012
	Modified Date:
=end
class Blog::PostsController < BlogController

   layout 'home'
   
  #include settings helper
  include SettingsHelper
  include BlogHelper
  
  #before_filter method starts here
  before_filter :find_blog_post, :find_tags
  before_filter :find_all_blog_posts, :except =>[:archive]
  before_filter :load_css
  
  #before_filter :layout_include


  respond_to :html, :js, :rss

  
  #Crudify method used for a normal crud methods by crudify gem
  #It creates new, create, edit, update, delete, show methods for blog post
  crudify :blog_post,
          :title_attribute => :title,
          :order => 'published_at DESC'

  def comment
    @blog_post = BlogPost.find(params[:id])
    if (@blog_comment = @blog_post.comments.create(params[:blog_comment])).valid?
      if BlogComment::Moderation.enabled? or @blog_comment.ham?
        begin
          Blog::CommentMailer.notification(@blog_comment).deliver          
        rescue
          logger.warn "There was an error delivering a blog comment notification.\n#{$!}\n"
        end
      end

      if BlogComment::Moderation.enabled?
        flash[:notice] = t('blog.posts.comments.thank_you_moderated')
        redirect_to blog_post_url(params[:id])
      else
        flash[:notice] = t('blog.posts.comments.thank_you')
        redirect_to blog_post_url(params[:id],
                                  :anchor => "comment-#{@blog_comment.to_param}")
      end
    else
      render :action => 'show'
    end
  end

  #tagged method for listing tagged blog posts
  def tagged
    @tag = ActsAsTaggableOn::Tag.find(params[:tag_id])
    @tag_name = @tag.name
    @blog_posts = BlogPost.tagged_with(@tag_name).paginate({
      :page => params[:page],
      :per_page => blog_posts_per_page
    })
  end

  #archive method for listing archived blog posts
  def archive
    
    if params[:month].present?
      date = "#{params[:month]}/#{params[:year]}"
      @archive_date = Time.parse(date)
      @date_title = @archive_date.strftime('%B %Y')
      @blog_posts = BlogPost.live.by_archive(@archive_date).paginate({
        :page => params[:page],
        :per_page => blog_posts_per_page
      })
    else
      date = "01/#{params[:year]}"
      @archive_date = Time.parse(date)
      @date_title = @archive_date.strftime('%Y')
      @blog_posts = BlogPost.live.by_year(@archive_date).paginate({
        :page => params[:page],
        :per_page => blog_posts_per_page
      })
    end
    respond_with (@blog_posts)
  end

  #protected methods start here
  protected

  def load_css
    AssetManager.include_css [ :blog_home, :home]
  end

  #find blog post for  a parameter of blog post id
  def find_blog_post
    @blog_categories = BlogCategory.all
    unless (@blog_post = BlogPost.find(params[:id])).try(:live?)
      #if refinery_user? and current_user.authorized_plugins.include?("refinerycms_blog")
        @blog_post = BlogPost.find(params[:id])
      #else
      #  error_404
      #end
    end
  end

  #This method refers to find all blog posts
  def find_all_blog_posts
    @blog_posts = BlogPost.live.includes(:comments, :categories).paginate({
      :page => params[:page],
      :per_page => blog_posts_per_page
    })
  end

  #finding tags for blog posts
  def find_tags
    @tags = BlogPost.tag_counts_on(:tags)
  end

  
 
end
