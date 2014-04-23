	class HomeController < ApplicationController
  def index
  	@user = current_user if signed_in?
  	@topics = Topic.order(created_at: :desc).paginate(page: params[:page], :per_page =>5)
  	#@goodtopics = Topic.order(rating: :desc).paginate(page: params[:page], :per_page =>5)
  	@goodtopics = Topic.limit(5).order(rating: :desc)
  
  end

  def about
  end
end
