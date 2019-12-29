class QuizzController < ApplicationController
  def take
    @questions = current_user.questions
  end

  def result
    @questions = current_user.questions
    @score = 0
    @questions.each_with_index do |question, index|
      @score += 1 if question.right_answer_id == params[index.to_s].to_i
    end
    @right_answers_rate = (@score * 100 / @questions.size.to_f).round(2)
    render :result
  end
end
