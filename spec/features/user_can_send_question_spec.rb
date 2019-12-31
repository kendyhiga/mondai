require 'rails_helper'

feature 'user can send question' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    fill_in :content, with: 'Rails is based upon which development language?'
    click_on 'Add'

    expect(current_path).to eq(question_path(Question.last))
    expect(page).to have_content('Question registered successfully')
    expect(page).to have_content('Rails is based upon which development language?')
    expect(page).to have_content("Sent by: #{user.email}")
  end

  scenario 'and the question cannot be blank' do
    user = User.create!(email: 'user@email.com', password: 123456)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    fill_in :content, with: ''
    click_on 'Add'

    expect(current_path).to eq(questions_path)
    expect(page).to have_content("Content can't be blank")
    expect(page).not_to have_content('Question registered successfully')
    expect(page).not_to have_content('Rails is based upon which development language?')
    expect(page).not_to have_content("Sent by: #{user.email}")
    expect(page).not_to have_link('Add answer')
  end

  scenario 'and the user must be logged in' do
    visit questions_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
