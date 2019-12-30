require 'rails_helper'

feature 'user can delete answers' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    answer = Answer.create!(content: 'Rubi', user: user, question: question)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Delete answer'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Answer deleted successfully')
    expect(page).not_to have_content(answer.content)
    expect { answer.reload }.to raise_error ActiveRecord::RecordNotFound
  end
end
