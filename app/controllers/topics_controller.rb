class TopicsController < ApplicationController
	 before_action :signed_in_user, only: [:create, :destroy, :new, :edit, :update, :rate]
   before_action :correct_user,   only: [:destroy, :edit, :update]

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

  def edit
    @user = current_user if signed_in?
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(topic_params)
      flash.now[:success] = "Topic updated"
      redirect_to topic_path(@topic)
    else
      render 'edit'
    end
  end

	def destroy
    @topic.destroy
    redirect_to main_path
	end

  def search
    @user = current_user if signed_in?
    @topics = Topic.search do 
      fulltext params[:topic]
      paginate(page: params[:page], :per_page =>10)
    end.results
            
  end

  def rate
    
    @topic = Topic.find(params[:id])
    @topic.update_column(:rating,@topic.rating+1)
    #@topic.increment(:rating)
    #@topic.save
    #redirect_to root_url
    redirect_to :back
  end

private

  	def topic_params
    		params.require(:topic).permit(:subject,:body,:professor_name, :course_number)
  	end

    def correct_user
      @topic = current_user.topics.find_by(id: params[:id])
      redirect_to main_path if @topic.nil?
    end
end
