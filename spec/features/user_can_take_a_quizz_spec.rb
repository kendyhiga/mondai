require 'rails_helper'

feature 'user can take a quizz' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    Answer.create!(content: 'Elixir', user: user, question: question)
    right_answer = Answer.create!(content: 'Ruby', user: user, question: question)
    Answer.create!(content: 'Java', user: user, question: question)
    Answer.create!(content: 'Python', user: user, question: question)
    question.update(right_answer_id: right_answer.id)

    second_question = Question.create!(content: 'x = 15 + 5 * 2 - 5, whats the value of x?', user: user)
    Answer.create!(content: '35', user: user, question: second_question)
    Answer.create!(content: '0', user: user, question: second_question)
    second_right_answer = Answer.create!(content: '20', user: user, question: second_question)
    Answer.create!(content: '-60', user: user, question: second_question)
    second_question.update(right_answer_id: second_right_answer.id)

    third_question = Question.create!(content: 'Which is the correct way of naming a variable in Ruby?', user: user)
    Answer.create!(content: 'Putting spaces in it: "first name"', user: user, question: third_question)
    Answer.create!(content: 'Starting with a number: "1st_name"', user: user, question: third_question)
    Answer.create!(content: 'With CamelCase: "firstName"', user: user, question: third_question)
    third_right_answer = Answer.create!(content: 'With snake_case: "first_name"', user: user, question: third_question)
    third_question.update(right_answer_id: third_right_answer.id)

    login_as user
    visit root_path
    click_on 'Take a quizz'
    choose right_answer.content
    choose second_right_answer.content
    choose third_right_answer.content
    click_on 'Send'

    expect(current_path).to eq(result_quizz_path)
    expect(page).to have_content('You got 3 out of 3 questions right, 100.0% score!')
  end

  scenario 'and it calculates right the final rate score' do
    user = User.create!(email: 'user@email.com', password: 123456)
    question = Question.create!(content: 'Rails is based upon which development language?', user: user)
    Answer.create!(content: 'Elixir', user: user, question: question)
    right_answer = Answer.create!(content: 'Ruby', user: user, question: question)
    wrong_answer = Answer.create!(content: 'Java', user: user, question: question)
    Answer.create!(content: 'Python', user: user, question: question)
    question.update(right_answer_id: right_answer.id)

    second_question = Question.create!(content: 'x = 15 + 5 * 2 - 5, whats the value of x?', user: user)
    Answer.create!(content: '35', user: user, question: second_question)
    Answer.create!(content: '0', user: user, question: second_question)
    second_right_answer = Answer.create!(content: '20', user: user, question: second_question)
    Answer.create!(content: '-60', user: user, question: second_question)
    second_question.update(right_answer_id: second_right_answer.id)

    third_question = Question.create!(content: 'Which is the correct way of naming a variable in Ruby?', user: user)
    Answer.create!(content: 'Putting spaces in it: "first name"', user: user, question: third_question)
    Answer.create!(content: 'Starting with a number: "1st_name"', user: user, question: third_question)
    Answer.create!(content: 'With CamelCase: "firstName"', user: user, question: third_question)
    third_right_answer = Answer.create!(content: 'With snake_case: "first_name"', user: user, question: third_question)
    third_question.update(right_answer_id: third_right_answer.id)

    login_as user
    visit root_path
    click_on 'Take a quizz'
    choose wrong_answer.content
    choose second_right_answer.content
    choose third_right_answer.content
    click_on 'Send'

    expect(current_path).to eq(result_quizz_path)
    expect(page).to have_content('You got 2 out of 3 questions right, 66.67% score!')
  end

  scenario 'and receives a message if no question is available' do
    user = User.create!(email: 'user@email.com', password: 123456)

    login_as user
    visit root_path
    click_on 'Take a quizz'

    expect(current_path).to eq(take_quizz_path)
    expect(page).to have_content("There's currently no questions available, create one yourself right now: ")
    expect(page).to have_link('create question')
  end
end
