=begin
	@Name: Application controller
	@Use:  This is the main application controller which is public to all project files
	@Created date: 08-06-2012
	@Modified Date: 12-06-2012
  @Company:  Mindfire Solutions
=end
class ApplicationController < ActionController::Base
  protect_from_forgery

  include BlogHelper
  
  #calling before filter for load_js
  
  before_filter :find_tags

  #Assigning array of javascript needed for all pages defaultly
  def load_assets
    AssetManager.include_contrib_library [:core_ui, :jquery_tab]
    AssetManager.include_css "blog_global"
  end

  

  def find_tags
    @tags = BlogPost.tag_counts_on(:tags)
  end

end
