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
      flash[:alert] = @question.errors.full_messages
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end

  private

    def question_params
      params.require(:question).permit(:content)
    end
end
