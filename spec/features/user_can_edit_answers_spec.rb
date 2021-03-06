require 'rails_helper'

feature 'user can edit answers' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    Answer.create!(content: 'Rubi', user: user, question: question)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Edit'
    fill_in 'editing_answer', with: 'Ruby'
    click_on 'Save'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Answer edited successfully')
    expect(page).to have_content('Ruby')
  end

  scenario 'and the user must be logged in' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    answer = Answer.create!(content: 'Rubi', user: user, question: question)

    visit edit_question_answer_path(question, answer)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
