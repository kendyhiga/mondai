require 'rails_helper'

feature 'user can edit question' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Edit question'
    fill_in 'Content', with: 'Phoenix is based upon which development language?'
    click_on 'Send'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content('Phoenix is based upon which development language?')
    expect(page).to have_content('Question edited successfully')
  end

  scenario 'and the question cannot be blank' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Edit question'
    fill_in 'Content', with: ''
    click_on 'Send'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content("Content can't be blank")
  end
end
