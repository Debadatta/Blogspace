=begin
  @Name : routes.rb
  @Use   : Defines the rails routing for pages
  @Created at :8-6-2012
  @Modified at : 13-06-2012
  @Company   :  Mindfire Solutions
=end
Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  root :to => 'admin/blog/posts#index'
  mount Ckeditor::Engine => "/ckeditor"

  scope(:path => 'blog', :module => 'blog') do
    root :to => 'posts#index', :as => 'blog_root'
    match ':id', :to => 'posts#show', :as => 'blog_post'
    match 'categories/:id', :to => 'categories#show', :as => 'blog_category'
    match 'feed.rss', :to => 'posts#index.rss', :as => 'blog_rss_feed'
    match ':id/comments', :to => 'posts#comment', :as => 'blog_post_blog_comments'
    get 'tagged/:tag_id/:tag_name' => 'posts#tagged', :as => 'tagged_posts'
    get 'archive/:year(/:month)', :to => 'posts#archive', :as => 'archive_blog_posts'
  end

  #Admin module pages routing
  #scope(:path => 'admin', :module => 'admin') do
    #scope(:path => 'blog', :as => 'blog', :module => 'blog') do           #Blog module under admin module pages routing
  namespace :admin do
    namespace :blog do
      root :to => 'posts#index'
      resources :posts do
        collection do
          get :uncategorized
          get :tags
        end
      end

      #resource categories
      resources :categories

      #resource comments
      resources :comments do
        collection do
          get :approved
          get :rejected
        end
        member do
          get :approved
          get :rejected
        end
      end

      #resource settings
      resources :settings do
        collection do
          get :notification_recipients
          post :notification_recipients

          get :moderation
          get :comments
        end
      end
    end
  end

end
