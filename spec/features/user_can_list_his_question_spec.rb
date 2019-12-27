require 'rails_helper'

feature 'user can list only his questions' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    other_user = User.create!(email: 'other_user@email.com', password: 123456)
    question = Question.create!(question: 'Rails is based upon which development language?', user: user)
    other_question = Question.create!(question: 'Can you tell which code does not work?', user: user)
    other_user_question = Question.create!(question: 'Can you tell where is the bug?', user: other_user)

    login_as user
    visit root_path
    click_on 'Your questions'

    expect(page).to have_link(question.question)
    expect(page).to have_link(other_question.question)
    expect(page).not_to have_link(other_user_question.question)
  end
end
