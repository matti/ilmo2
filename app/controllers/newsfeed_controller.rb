class NewsfeedController < ApplicationController

  skip_before_filter :is_authenticated?, :only => [ :show ]
  
  def show
    @newsfeed = Newsfeed.latest
    
    respond_to do |format|
      format.rss
    end
  end
  
end
