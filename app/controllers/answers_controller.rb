class AnswersController < ApplicationController
  def new
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      flash[:notice] = 'Answer added'
      redirect_to @question
    else
      render :new
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    if @answer.update(params.require(:answer).permit(:content))
      flash[:notice] = 'Answer edited successfully'
      redirect_to @question
    else
      flash[:alert] = @answer.errors.full_messages
      render :edit
    end
  end

  def set_as_right
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
    @question.right_answer = @answer

    if @question.save
      flash[:notice] = 'Right answer choosed'
      redirect_to @question
    end
  end

  private

  def answer_params
    params.permit(:content)
  end
end
