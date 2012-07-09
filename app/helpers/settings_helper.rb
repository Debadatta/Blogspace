=begin
  @Name : SettingsHelper
  @Purpose: This is a helper file for settings related configurations
  @Created_at : 20-06-2012
  @Modified_at : 20-06-2012
  @Company : Mindfire Solutions
=end
module SettingsHelper

  #settings for blog posts to be commentable
  #returns 1
  def self.commentable
    return 1
  end

  #settings for blog posts to be uncommentable
  #returns 0
  def self.uncommentable
    return 0
  end

  #settings for blog posts to be moderatable
  #returns 1
  def self.moderatable
    return 1
  end

  #settings for blog posts to be unmoderatable
  #returns 0
  def self.unmoderatable
    return 0
  end

  def blog_posts_per_page
    10
  end
  
end
