require 'rails_helper'

feature 'user can publish question' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    answer = Answer.create!(content: 'Ruby', user: user, question: question)
    Answer.create!(content: 'Elixir', user: user, question: question)
    Answer.create!(content: 'Java', user: user, question: question)
    Answer.create!(content: 'Python', user: user, question: question)
    question.update(right_answer_id: answer.id)
    topic = Topic.create!(name: 'Development')
    question.topics << topic

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Publish'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Published')
    expect(page).not_to have_content('Draft')
    expect(page).to have_content('Question is published')
  end

  scenario 'and it must have at least two answer' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    answer = Answer.create!(content: 'Ruby', user: user, question: question)
    question.update(right_answer_id: answer.id)
    topic = Topic.create!(name: 'Development')
    question.topics << topic

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Publish'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Draft')
    expect(page).not_to have_content('Published')
    expect(page).to have_content('Question is not published')
    expect(page).to have_content('Must have at least two answers')
  end

  scenario 'and it must have a right answer' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    Answer.create!(content: 'Ruby', user: user, question: question)
    Answer.create!(content: 'Elixir', user: user, question: question)
    Answer.create!(content: 'Java', user: user, question: question)
    Answer.create!(content: 'Python', user: user, question: question)
    topic = Topic.create!(name: 'Development')
    question.topics << topic

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Publish'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Draft')
    expect(page).not_to have_content('Published')
    expect(page).to have_content('Question is not published')
    expect(page).to have_content('Must have an right answer chosen')
  end

  scenario 'and it must have at least one topic' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    answer = Answer.create!(content: 'Ruby', user: user, question: question)
    Answer.create!(content: 'Elixir', user: user, question: question)
    Answer.create!(content: 'Java', user: user, question: question)
    Answer.create!(content: 'Python', user: user, question: question)
    question.update(right_answer_id: answer.id)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Publish'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Draft')
    expect(page).not_to have_content('Published')
    expect(page).to have_content('Question is not published')
    expect(page).to have_content('Must have at least one topic')
  end

  scenario 'and can unpublish it' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    answer = Answer.create!(content: 'Ruby', user: user, question: question)
    Answer.create!(content: 'Elixir', user: user, question: question)
    Answer.create!(content: 'Java', user: user, question: question)
    Answer.create!(content: 'Python', user: user, question: question)
    question.update(right_answer_id: answer.id)
    topic = Topic.create!(name: 'Development')
    question.topics << topic
    question.update(published: true)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Unpublish'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Draft')
    expect(page).not_to have_content('Published')
    expect(page).to have_content('Question is not published')
  end
end
