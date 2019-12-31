class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params.require(:topic).permit(:name))
    @topic.name.capitalize!

    if @topic.save
      flash[:notice] = 'Topic created successfully'
      redirect_to topics_path
    else
      flash[:alert] = @topic.errors.full_messages
      render :new
    end
  end
end
