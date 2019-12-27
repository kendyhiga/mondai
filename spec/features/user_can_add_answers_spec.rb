require 'rails_helper'

xfeature 'user can add answers' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(question: 'Rails is based upon which development language?', user: user)

    login_as user
    visit root_path
    click_on 'Your questions'
    click_on question.question

    expect(page).to have_link(question.question)
    expect(page).to have_link(other_question.question)
    expect(page).not_to have_link(other_user_question.question)
  end
end
