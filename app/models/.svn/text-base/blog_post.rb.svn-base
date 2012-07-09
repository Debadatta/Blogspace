=begin
  @Name    :BlogPost model
  @Created at :12-06-2012
  @Updated at  :12-06-2012
  @Purpose :Needed for initailizing activerecord for blog_posts table in rails
  @Company : Mindfire Solutions
=end

class BlogPost < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  #setting a table name prefix with mcms_
  self.table_name = 'mcms_blog_posts'

  

  
  #attribute accessibles
   attr_accessible :title, :body, :tag_list, :draft, :published_at, :browser_title, :meta_keywords, :meta_description, :user_id, :category_ids, :custom_url, :custom_teaser,
     :cached_slug

  #Defining model associations
  belongs_to :author, :class_name => 'User', :foreign_key => :user_id
  has_many :comments, :class_name => 'BlogComment', :dependent => :destroy
  has_many :categorizations
  has_many :categories, :through => :categorizations, :source => :blog_category

  #validation rules
  validates :title, :presence => true
  validates :body,  :presence => true

  #acts_as_taggable for blog posts
  acts_as_taggable

  #setting a default scope for all records
  default_scope :order => 'published_at DESC'

  #defining scope for user-defined functionality
  scope :live, lambda { where( "published_at <= ? and draft = ?", Time.now, false) }
  scope :all_previous, lambda { where(['published_at <= ?', Time.now.beginning_of_month]) }
  scope :by_archive, lambda { |archive_date|
    where(['published_at between ? and ?', archive_date.beginning_of_month, archive_date.end_of_month])
  }

  scope :by_year, lambda { |archive_year|
    where(['published_at between ? and ?', archive_year.beginning_of_year, archive_year.end_of_year])
  }


  def live?
    !draft and published_at <= Time.now
  end
  
  #class methods started here
  class << self
    def next current_record
      self.send(:with_exclusive_scope) do
        where(["published_at > ? and draft = ?", current_record.published_at, false]).order("published_at ASC")
      end
    end

    def comments_allowed?
#      RefinerySetting.find_or_set(:comments_allowed, true, {
#        :scoping => 'blog'
#      })
    end

    def uncategorized
      BlogPost.live.reject { |p| p.categories.any? }
    end
  end

  #Added module for settings
  module CommentSetting
    class << self

      #this method returns true if comments_allowed value is true or 1 neither false in settings table
      def is_comments_allowed?
        value = Setting.find_by_name('comment_allowed').value
         if value.to_i == 1
           return true
         else
           return false
         end
      end

      #this method returns true if comments_moderated value is true or 1 neither false in settings table
      def is_comments_moderated?
        value = Setting.find_by_name('comment_moderation').value
        if value.to_i == 1
           true
         else
           false
         end
      end

      #this method update the comments_allowed value to false
      def do_uncommentable
        Setting.blog_uncommentable_setting
      end

      #this method update the comments_allowed value to true
      def do_commentable
        Setting.blog_commentable_setting
      end

      #this method update the comments_allowed value to false
      def do_unmoderatable
        Setting.blog_unmoderatable_setting
      end

      #this method update the comments_allowed value to true
      def do_moderatable
        Setting.blog_moderatable_setting
      end

    end
  end
  
end
