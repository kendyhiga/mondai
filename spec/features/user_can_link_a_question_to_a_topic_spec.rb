require 'rails_helper'

feature 'user can link a question to a topic' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    Question.create!(content: 'Rails is based upon which development language?', user: user)
    Topic.create!(name: 'Development')

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on 'Edit'
    select 'Development', from: :question_topic_id
    click_on 'Save'

    expect(current_path).to eq(questions_path)
    expect(page).to have_content('Question edited successfully')
    expect(page).to have_content('Development')
  end
end
