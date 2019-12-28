require 'rails_helper'

feature 'user can edit answers' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    answer = Answer.create!(content: 'Rubi', user: user, question: question)

    login_as user
    visit root_path
    click_on 'Your questions'
    click_on question.content
    click_on answer.content
    fill_in 'Content', with: 'Ruby'
    click_on 'Send'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Answer edited successfully')
    expect(page).to have_content('Ruby')
  end
end
