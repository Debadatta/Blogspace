=begin
  @Name    :BlogComment model
  @Created at :12-06-2012
  @Updated at  :12-06-2012
  @Purpose :Needed for initailizing activerecord for blog_comments table in rails
  @Company  :Mindfire Solutions
=end
class BlogComment < ActiveRecord::Base

  #set a table name prefix
  self.table_name = 'mcms_blog_comments'
  
  #including NotificationHelper for notification helper methods
  include ApplicationHelper

  #attribute accessibles
  attr_accessible :name, :email,  :body, :blog_post_id, :state

  #defining model associations
  belongs_to :post, :class_name => 'BlogPost', :foreign_key => 'blog_post_id'

  #validation rules
  validates :name, :body, :presence => true
  validates :email, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  #defining some scopes for lambda call
  scope :unmoderated, :conditions => {:state=> nil}
  scope :approved, :conditions => {:state => 'approved'}
  scope :rejected, :conditions => {:state => 'rejected'}


  #Set the approved state for the comment
  def approve!
    self.update_attribute(:state, 'approved')
  end

  #Set the reject state for the comment
  def reject!
    self.update_attribute(:state, 'rejected')
  end

  #Findout whether the comment is rejected or not
  def is_rejected?
    self.state == 'rejected'
  end

  #Findout whether the comment is approved or not
  def is_approved?
    self.state == 'approved'
  end

  #Findout whether the comment is unmoderated or not
  def is_unmoderated?
    self.state.nil?
  end

  #Notification module related to comment notifications
  module Notification
    
    class << self
      #recipients method setting or finding a perticular recipient for mcms
      def recipients
        #notify_me
      end

      def recipients=(emails)
        Setting.set_notification_recipient(emails)
      end

      def subject
        "New inquiry from your website"
      end

      def find_notification_recipient
        Setting.find_notification_recipient
      end

    end
  end

  #Moderation module for comments
  module Moderation
    class << self
      def enabled?
        value = Setting.find_by_name('comment_moderation').value
         if value.to_i == 1
           return true
         else
           return false
         end
      end

      def toggle!
        new_value = {
          :value => !BlogComment::Moderation.enabled?,
          :scoping => 'blog',
          :restricted => false
        }
        if RefinerySetting.respond_to?(:set)
          RefinerySetting.set(:comment_moderation, new_value)
        else
          RefinerySetting[:comment_moderation] = new_value
        end
      end
    end
  end
  

end
