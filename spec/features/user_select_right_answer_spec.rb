require 'rails_helper'

feature 'user can select right answer' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    answer = Answer.create!(content: 'Ruby', user: user, question: question)
    Answer.create!(content: 'Java', user: user, question: question)
    Answer.create!(content: 'Python', user: user, question: question)
    Answer.create!(content: 'Elixir', user: user, question: question)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    find("##{answer.id}").click

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content('Ruby')
    expect(page).to have_content('Right answer')
    expect(page).to have_content('Java')
    expect(page).to have_content('Python')
    expect(page).to have_content('Elixir')
    expect(page).to have_content('Choose as right answer')
    expect(page).to have_content('Right answer choosed')
  end
end
