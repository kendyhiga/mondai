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
      flash[:alert] = @question.errors.full_messages
    end
    redirect_to @question
  end

  def edit
    @questions = current_user.questions
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = 'Question edited successfully'
    else
      flash[:alert] = @question.errors.full_messages
    end
    redirect_to questions_path
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = 'Question deleted successfully'
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:content)
  end
end
