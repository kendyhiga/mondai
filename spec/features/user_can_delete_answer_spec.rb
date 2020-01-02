require 'rails_helper'

feature 'user can delete answers' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    answer = Answer.create!(content: 'Ruby', user: user, question: question)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Delete answer'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Answer deleted successfully')
    expect(page).not_to have_content(answer.content)
    expect { answer.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  scenario 'even if it its the right one' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    answer = Answer.create!(content: 'Ruby', user: user, question: question)
    question.update(right_answer_id: answer.id)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Delete answer'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Answer deleted successfully')
    expect(page).not_to have_content(answer.content)
    expect { answer.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  xscenario 'and the others answers remain the same' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    answer = Answer.create!(content: 'Ruby', user: user, question: question)
    other_answer = Answer.create!(content: 'Elixir', user: user, question: question)
    another_answer = Answer.create!(content: 'Java', user: user, question: question)
    different_answer = Answer.create!(content: 'Python', user: user, question: question)
    question.update(right_answer_id: answer.id)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Delete answer'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content(question.content)
    expect(page).to have_content('Answer deleted successfully')
    expect(page).not_to have_content(answer.content)
    expect(page).to have_content(other_answer.content)
    expect(page).to have_content(another_answer.content)
    expect(page).to have_content(different_answer.content)
    expect { answer.reload }.to raise_error ActiveRecord::RecordNotFound
  end
end
