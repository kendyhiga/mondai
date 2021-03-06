require 'rails_helper'

feature 'user can edit question' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Edit'
    fill_in 'editing_question', with: 'Phoenix is based upon which development language?'
    click_on 'Save'

    expect(current_path).to eq(questions_path)
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
    click_on 'Edit'
    fill_in 'editing_question', with: ''
    click_on 'Save'

    expect(current_path).to eq(questions_path)
    expect(page).to have_content("Content can't be blank")
  end
end
