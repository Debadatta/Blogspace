=begin
  @Name    :Setting model
  @Created at :19-06-2012
  @Updated at  :20-06-2012
  @Purpose :Needed for initailizing activerecord for mcms_settings table in rails
  @Company  :Mindfire Solutions
=end
class Setting < ActiveRecord::Base
  
  #setting a table name prefix with mcms_
  self.table_name = 'mcms_settings'

  #including SettingsHelper to call helper methods here  
  include SettingsHelper

  #attr_accessibles
  attr_accessible :name, :value, :destroyable

  #make settings for blogs to be uncommentable by updating attribute value to 0
  def self.blog_uncommentable_setting
    self.find_by_name('comment_allowed').update_attribute(:value, SettingsHelper.uncommentable)
  end

  #make settings for blogs to be commentable by updating attribute value to 1
  def self.blog_commentable_setting    
    self.find_by_name('comment_allowed').update_attribute(:value, SettingsHelper.commentable)
  end

  #make settings for blogs to be unmoderatable by updating attribute value to 0
  def self.blog_unmoderatable_setting
    self.find_by_name('comment_moderation').update_attributes(:value => SettingsHelper.unmoderatable)
  end

  #make settings for blogs to be moderatable by updating attribute value to 1
  def self.blog_moderatable_setting
    self.find_by_name('comment_moderation').update_attributes(:value => SettingsHelper.moderatable)
  end

  #retrieve notification_recipient email
  def self.notification_recipient
    email_id = self.find_by_name('notication_recipient').email
    if email_id.present?
      return email_id
    else
      return User.first.email
    end
  end

  #Setting notification recipients emails.
  def self.set_notification_recipient(emails)
    self.find_by_name('notification_recipient').update_attributes(:value => emails)
  end

  #Finding notification recipients emails.
  def self.find_notification_recipient
    self.find_by_name('notification_recipient').value
  end
  
end
