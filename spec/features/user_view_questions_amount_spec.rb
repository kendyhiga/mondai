require 'rails_helper'

feature 'user can take a quiz' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    Question.create!(content: 'Rails is based upon which development language?', user: user)
    Question.create!(content: 'x = 15 + 5 * 2 - 5, whats the value of x?', user: user)
    Question.create!(content: 'Which is the correct way of naming a variable in Ruby?', user: user)

    login_as user
    visit root_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content('3')
  end
end
