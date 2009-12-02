class RegistrationsController < ApplicationController


  def create
    
    exercise_group = ExerciseGroup.find(params[:exercise_group_id])
    registration = current_user.registrations.build :exercise_group => exercise_group
    
    if registration.save
      flash[:notice] = "Registration was successfull"
    else
      flash[:error] = "You have already registered to this course instance"
    end
    
    redirect_to :back
  end
  
  def destroy
    registration_to_exercise_group = current_user.registrations.find_by_exercise_group_id(params[:exercise_group_id])
    registration_to_exercise_group.destroy
    
    redirect_to :back
  end
  
end
