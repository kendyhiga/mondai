class QuizzController < ApplicationController
  def take
    @questions = current_user.questions.select { |question| question.answers.any? }
  end

  def result
    @questions = current_user.questions.select { |question| question.answers.any? }
    @score = calculate_score(@questions)
    @right_answers_rate = calculate_score_percentage(@score, @questions.size)
    render :result
  end

  private

  def calculate_score(questions)
    score = 0
    questions.each_with_index do |question, index|
      score += 1 if question.right_answer_id == params[index.to_s].to_i
    end
    score
  end

  def calculate_score_percentage(score, total_size)
    (score * 100 / total_size.to_f).round(2)
  end
end
