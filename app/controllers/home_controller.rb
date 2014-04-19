	class HomeController < ApplicationController
  def index
  	@user = current_user if signed_in?
  	@topics = Topic.all.paginate(page: params[:page], :per_page =>10)

  end

  def about
  end
end
