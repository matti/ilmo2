class CoursesController < ApplicationController

  def index
    @courses = Course.all
    @newsfeed_items = Newsfeed.latest(5)
    
    respond_to do |format|
      format.html
      format.pdf { send_data PdfExport.all_courses(@courses) }
    end
  end

  def show
    @course = Course.find(params[:id])
  end

end
