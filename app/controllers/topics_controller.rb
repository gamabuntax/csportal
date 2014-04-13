class TopicsController < ApplicationController
	 before_action :signed_in_user, only: [:create, :destroy, :new]
   before_action :correct_user,   only: :destroy

  def show
      @user = current_user if signed_in?
      @topic = Topic.find(params[:id])
  end

	def new
    @user = current_user
		@topic = current_user.topics.build if signed_in?
	end

	def create
    @user = current_user
		@topic = current_user.topics.build(topic_params)
		if @topic.save
			flash[:success] = "Topic created!"
			redirect_to main_path
		else
			render 'new'
		end	
 	end

	def destroy
    @topic.destroy
    redirect_to main_path
	end

  def search
    @topics = Topic.search do 
      fulltext params[:topic]
    end.results
            
  end

private

  	def topic_params
    		params.require(:topic).permit(:subject,:body)
  	end

    def correct_user
      @topic = current_user.topics.find_by(id: params[:id])
      redirect_to main_path if @topic.nil?
    end
end
