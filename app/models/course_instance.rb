class CourseInstance < ActiveRecord::Base

  belongs_to :course
  has_many :exercise_groups, :dependent => :destroy


  def allows_multiple_groups?
    max_groups && max_groups > 1
  end
end
