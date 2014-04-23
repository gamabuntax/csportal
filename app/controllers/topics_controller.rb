class TopicsController < ApplicationController
	 before_action :signed_in_user, only: [:create, :destroy, :new, :edit, :update, :like, :dislike]
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
      flash[:success] = "Topic updated"
      redirect_to topic_path(@topic)
    else
      render 'edit'
    end
  end

	def destroy
    @topic.destroy
    redirect_to root_path
	end

  def search
    @user = current_user if signed_in?
    #@topics = Topic.search(params[:topic]).records
    @topics = Topic.search params[:topic], :page => ( params[:page] || 1 ), :per_page => 10
    # @topics = Topic.search do 
    #   fulltext params[:topic]
    #   paginate(page: params[:page], :per_page =>10)
    # end.results          
  end

  def like
    @user = current_user if signed_in?
    @topic = Topic.find(params[:id])
    #if(Ratingtopic.find(:topic_id => params[:id], :user_id => @user))
    if(Ratingtopic.find_by(:topic_id => params[:id], :user_id => @user.id))
      flash[:error] = "You are already rated this topic"
      redirect_to :back
    else
      @topic.update_column(:rating,@topic.rating+1)
      @ratingtopic = Ratingtopic.new(:topic_id =>params[:id], :user_id =>@user.id)
      @ratingtopic.save
      @topic.update_index
      flash[:success] = "You rated this topic successfully"
      redirect_to :back
      #redirect_to :back
    end
  end

  def dislike
    @user = current_user if signed_in?
    @topic = Topic.find(params[:id])
    #if(Ratingtopic.find(:topic_id => params[:id], :user_id => @user))
    if(Ratingtopic.find_by(:topic_id => params[:id], :user_id => @user.id))
      flash[:error] = "You are already rated this topic"
      redirect_to :back
    else
      @topic.update_column(:rating,@topic.rating-1)
      @ratingtopic = Ratingtopic.new(:topic_id =>params[:id], :user_id =>@user.id)
      @ratingtopic.save
      @topic.update_index
      flash[:success] = "You rated this topic successfully"
      redirect_to :back
      #redirect_to :back
    end
  end

private

  	def topic_params
    		params.require(:topic).permit(:subject,:body,:professor_name, :course_number)
  	end

    def correct_user
      #@topic = current_user.topics.find_by(id: params[:id])
      @topic = Topic.find_by(id: params[:id])
      redirect_to main_path if @topic.nil?
    end

end
