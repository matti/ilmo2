class Newsfeed < ActiveRecord::Base
  
  belongs_to :target, :polymorphic => true
  validates_length_of :message_prefix, :in=>1..255
  
  default_scope :order=>"created_at DESC"
  
  named_scope :latest, lambda { |amount|
    {:limit => amount}
  }
  
  


  def self.course_created(course)
    create_message :prefix => "\"",
                   :link => course.name,
                   :suffix => "\" was added into course catalog",
                   :target => course
  end
  
  def self.user_account_created(user)
    create_message :prefix => "#{user.username} registered to the Ilmo 2.0",
                   :target => user
  end


  def self.user_registered_to_exercise_group(user, exercise_group)
    create_message :prefix => "#{user.username} is attending ",
                   :link => exercise_group.course_instance.course.name,
                   :target => exercise_group
  end
  
  private
  
  def self.create_message(options)
    Newsfeed.create!  :message_prefix => options[:prefix],
                      :message_suffix => options[:suffix],
                      :link_to_sentence => options[:link],
                      :target => options[:target]
  end
end
