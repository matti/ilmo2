class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise_group
  
  validate :must_be_the_only_registration_for_this_instance
  validate :check_that_registrations_are_not_exceeded
  validates_uniqueness_of :exercise_group_id, :scope => :user_id
  
  
  after_create :publish_registration_on_newsfeed

  protected
 
  
  # does 1 select with inner join:
  def must_be_the_only_registration_for_this_instance
    return if exercise_group.course_instance.allows_multiple_groups?

    errors.add(:exercise_group, "already registered in this instance") if user.exercise_groups.exists?(:course_instance_id => exercise_group.course_instance_id)
  end
  
  # (bad) alternative, does n SELECTS from the database
  # def must_be_first_registration_for_this_instance
  #   already_in_these_course_instances = user.exercise_groups.map(&:course_instance)
  #     
  #   errors.add(:exercise_group, "already registered in this instance") if already_in_these_course_instances.include? exercise_group.course_instance
  # end


  def check_that_registrations_are_not_exceeded
    return unless exercise_group.course_instance.allows_multiple_groups?

    currently_registered = user.exercise_groups.count :conditions => { :course_instance_id => exercise_group.course_instance_id }

    errors.add(:exercise_group, "maximum number of registrations reached") if currently_registered == exercise_group.course_instance.max_groups
  end
  
  private
  
  def publish_registration_on_newsfeed
    Newsfeed.user_registered_to_exercise_group(user, exercise_group)
  end
  
  
end
