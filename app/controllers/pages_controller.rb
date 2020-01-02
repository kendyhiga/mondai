class PagesController < ApplicationController
  def home
    @questions_amount = current_user.questions.size if current_user
  end
end
