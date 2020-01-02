require 'rails_helper'

feature 'user can create answers' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    fill_in :content, with: 'Ruby'
    click_on 'Add'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Answer added')
    expect(page).to have_content('Ruby')
  end

  scenario 'and can add multiple answers' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    Answer.create!(content: 'Ruby', user: user, question: question)
    Answer.create!(content: 'Java', user: user, question: question)
    Answer.create!(content: 'Python', user: user, question: question)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    fill_in :content, with: 'Elixir'
    click_on 'Add'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Answer added')
    expect(page).to have_content('Ruby')
    expect(page).to have_content('Java')
    expect(page).to have_content('Python')
    expect(page).to have_content('Elixir')
  end

  scenario 'and cannot add the same answer twice' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    Answer.create!(content: 'Ruby', user: user, question: question)
    Answer.create!(content: 'Java', user: user, question: question)
    Answer.create!(content: 'Python', user: user, question: question)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    fill_in :content, with: 'Ruby'
    click_on 'Add'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Ruby', count: 1)
    expect(page).to have_content('Content has already been taken')
  end

  scenario 'and content cannot be blank' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    fill_in :content, with: ''
    click_on 'Add'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).not_to have_content('Ruby')
    expect(page).to have_content("Content can't be blank")
  end
end
