class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = current_user.questions
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      flash[:notice] = 'Question registered successfully'
      redirect_to @question
    else
      flash.now[:alert] = @question.errors.full_messages
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = 'Question edited successfully'
      redirect_to @question
    else
      flash.now[:alert] = @question.errors.full_messages
      render :edit
    end
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
