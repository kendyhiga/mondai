require 'rails_helper'

feature 'user can list only his questions' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    other_user = User.create!(email: 'other_user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    other_question = Question.create!(content: 'Can you tell which code does not work?', user: user)
    other_user_question = Question.create!(content: 'Can you tell where is the bug?', user: other_user)

    login_as user
    visit root_path
    click_on 'Manage your questions'

    expect(current_path).to eq(questions_path)
    expect(page).to have_link(question.content)
    expect(page).to have_link(other_question.content)
    expect(page).not_to have_link(other_user_question.content)
  end

  scenario 'and user cannot view this page without being signed-in' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)

    visit question_path(question)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
