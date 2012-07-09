=begin
	Name: Categories controller
	Use:  Creating , modifying, deleting blog categories for the cms
	Created date: 27-06-2012
  Modified date: 27-06-2012
  Company : Mindfire Solutions
=end
class Blog::CategoriesController < BlogController

	layout 'home'
  #including Settings Helper
  include SettingsHelper

  before_filter :load_css
  
  #show to show category per id
   def show
    @category = BlogCategory.find(params[:id])
    @blog_posts = @category.posts.live.includes(:comments, :categories).paginate({
      :page => params[:page],
      :per_page => blog_posts_per_page
    })
  end

   #load_assets includes all css files for this controller
   def load_css
     AssetManager.include_css [:blog_home, :home]
   end
end
