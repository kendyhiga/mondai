require 'rails_helper'

feature 'user can unlink a topic from a question' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    topic = Topic.create!(name: 'Development')
    question.topics << topic

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on 'Edit'
    click_on "#{topic.name} [remove]"

    expect(current_path).to eq(edit_question_path(question))
    expect(page).to have_content('Topic removed from question successfully')
    expect(page).to have_content('Development')
  end
end
