=begin
	@Name: Admin Blog Settings controller
	@Use:  Creating , modifying, deleting blog settings for the cms
	@Created date: 08-06-2012
	@Modified Date: 29-06-2012
  @Company:  Mindfire Solutions
=end
class Admin::Blog::SettingsController < ::ApplicationController

  before_filter :load_assets
  
  #Assigning a layout admin for admin side controller
  layout 'admin'

  #Checking for the blog is commentable or not then do commentable or uncommentable
  def comments
    value = BlogPost::CommentSetting.is_comments_allowed?
    
    if value      
      BlogPost::CommentSetting.do_uncommentable
    else
      BlogPost::CommentSetting.do_commentable
    end

    redirect_to request.env['HTTP_REFERER']
  end

  #Checking for the blog is moderatable or not then do moderatable or moderatable
  def moderation
    value = BlogPost::CommentSetting.is_comments_moderated?

    if value
      BlogPost::CommentSetting.do_unmoderatable
    else
      BlogPost::CommentSetting.do_moderatable
    end

    redirect_to request.env['HTTP_REFERER']
  end

  #notification_recipients for notifying recipients
  def notification_recipients
    @recipients = BlogComment::Notification.recipients

    if request.post?
      BlogComment::Notification.recipients = params[:recipients]
      flash[:notice] = t('admin.blog.settings.notification_recipients.updated',
                         :recipients => BlogComment::Notification.recipients)
      unless request.xhr? 
        redirect_to admin_blog_posts_path
      else
        render :text => "<script type='text/javascript'>parent.window.location = '#{admin_blog_posts_path}';</script>",
               :layout => false
      end
    end
  end

  protected

  def load_assets
    AssetManager.include_css [:blog_global, :submenu]
  end
end
