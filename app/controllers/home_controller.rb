class HomeController < ApplicationController
  def index
  	
  	@topics = Topic.order(created_at: :desc).paginate(page: params[:page], :per_page =>5)
  	#@goodtopics = Topic.order(rating: :desc).paginate(page: params[:page], :per_page =>5)
  	@goodtopics = Topic.limit(5).order(rating: :desc)
  	
    @activeUsers = User.order("(select count(*) from topics where topics.user_id = users.id) desc").limit(5)
  
  end

  def about
  end
end
