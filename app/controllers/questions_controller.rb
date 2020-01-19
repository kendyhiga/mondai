class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = current_user.questions
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.order(:created_at)
  end

  def create
    @question = current_user.questions.build(params.permit(:content))

    if @question.save
      flash[:notice] = 'Question registered successfully'
    else
      flash[:alert] = @question.errors.full_messages.join(', ')
    end
    redirect_to @question
  end

  def edit
    @questions = current_user.questions
    @question = Question.find(params[:id])
    @topics = Topic.all
  end

  def update
    @question = Question.find(params[:id])
    QuestionTopic.create(question_id: @question.id,
                         topic_id: params[:question][:topic_id]) if params[:question][:topic_id]

    if @question.update(question_params)
      flash[:notice] = 'Question edited successfully'
    else
      flash[:alert] = @question.errors.full_messages.join(', ')
    end
    redirect_to questions_path
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = 'Question deleted successfully'
    redirect_to questions_path
  end

  def toggle_publication
    @question = Question.find(params[:question_id])
    @question.toggle(:published)

    if @question.save
      adverb = 'not ' unless @question.published
      flash[:notice] = "Question is #{adverb}published"
    else
      flash[:alert] = "Question is not published, #{@question.errors.full_messages.join(', ')}"
    end
    redirect_to @question
  end

  private

  def question_params
    params.require(:question).permit(:content)
  end
end
