class TopicsController < ApplicationController
  def index
    @topics = Topic.all.order('created_at DESC')
  end

  def create
    @topic = Topic.new(params.permit(:name))
    @topic.name.capitalize!

    if @topic.save
      flash[:notice] = 'Topic created successfully'
    else
      flash[:alert] = @topic.errors.full_messages.join(', ')
    end
    redirect_to topics_path
  end

  def destroy
    @topic = QuestionTopic.find_by(question_id: params[:question_id], topic: params[:id])
    @topic.destroy
    flash[:notice] = 'Topic removed from question successfully'
    redirect_to edit_question_path(params[:question_id])
  end
end
