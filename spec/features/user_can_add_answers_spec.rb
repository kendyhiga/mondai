require 'rails_helper'

feature 'user can add answers' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)

    login_as user
    visit root_path
    click_on 'Your questions'
    click_on question.content
    click_on 'Add answer'
    fill_in 'Content', with: 'Ruby'
    click_on 'Add'

    expect(page).to have_content(question.content)
    expect(page).to have_content('Answer added')
    expect(page).to have_content('Ruby')
  end
end
