class Admin::MailerController < AdminController
  
  def show
    @exercise_groups = ExerciseGroup.all
  end

  def create
    message_subject = params[:subject]
    message_body = params[:body]
    
    exercise_group = ExerciseGroup.find(params[:exercise_group_id])
    exercise_group.users.each do |user|
      UserMailer.deliver_message(user, message_subject, message_body) if user.email
    end
  end
end
