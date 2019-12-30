require 'rails_helper'

feature 'user can delete questions' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Delete question'

    expect(current_path).to eq(questions_path)
    expect(page).not_to have_content(question.content)
    expect(page).to have_content('Question deleted successfully')
    expect { question.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  scenario 'the answers are deleted too' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    answer = Answer.create!(content: 'Ruby', user: user, question: question)
    other_answer = Answer.create!(content: 'Java', user: user, question: question)
    another_answer = Answer.create!(content: 'Elixir', user: user, question: question)
    question.update(right_answer_id: answer.id)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on question.content
    click_on 'Delete question'

    expect(current_path).to eq(questions_path)
    expect(page).not_to have_content(question.content)
    expect(page).to have_content('Question deleted successfully')
    expect { answer.reload }.to raise_error ActiveRecord::RecordNotFound
    expect { other_answer.reload }.to raise_error ActiveRecord::RecordNotFound
    expect { another_answer.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  scenario 'and can delete from the question index too' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)

    login_as user
    visit root_path
    click_on 'Manage your questions'
    click_on 'Delete'

    expect(current_path).to eq(questions_path)
    expect(page).not_to have_content(question.content)
    expect(page).to have_content('Question deleted successfully')
    expect { question.reload }.to raise_error ActiveRecord::RecordNotFound
  end
end
