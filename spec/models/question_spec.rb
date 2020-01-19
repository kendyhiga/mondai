require 'rails_helper'

RSpec.describe Question, type: :model do
  context '#toggle_publication' do
    it 'is able to toggle published to true' do
      user = User.create!(email: 'user@email.com', password: 123456)
      question = Question.create!(content: 'Rails is based upon which development language?', user: user)
      answer = Answer.create!(content: 'Ruby', user: user, question: question)
      Answer.create!(content: 'Elixir', user: user, question: question)
      question.update(right_answer_id: answer.id)
      topic = Topic.create!(name: 'Development')
      question.topics << topic

      question.toggle(:published)
      question.save
      question.reload

      expect(question.published).to eq(true)
    end

    it 'must have at least two answer' do
      user = User.create!(email: 'user@email.com', password: 123456)
      question = Question.create!(content: 'Rails is based upon which development language?', user: user)
      answer = Answer.create!(content: 'Ruby', user: user, question: question)
      question.update(right_answer_id: answer.id)
      topic = Topic.create!(name: 'Development')
      question.topics << topic

      question.toggle(:published)
      question.save
      question.reload

      expect(question.published).to eq(false)
    end

    it 'must have a right answer' do
      user = User.create!(email: 'user@email.com', password: 123456)
      question = Question.create!(content: 'Rails is based upon which development language?', user: user)
      Answer.create!(content: 'Ruby', user: user, question: question)
      Answer.create!(content: 'Elixir', user: user, question: question)
      Answer.create!(content: 'Java', user: user, question: question)
      Answer.create!(content: 'Python', user: user, question: question)
      topic = Topic.create!(name: 'Development')
      question.topics << topic

      question.toggle(:published)
      question.save
      question.reload

      expect(question.published).to eq(false)
    end

    it 'must have at least one topic' do
      user = User.create!(email: 'user@email.com', password: 123456)
      question = Question.create!(content: 'Rails is based upon which development language?', user: user)
      answer = Answer.create!(content: 'Ruby', user: user, question: question)
      Answer.create!(content: 'Elixir', user: user, question: question)
      Answer.create!(content: 'Java', user: user, question: question)
      Answer.create!(content: 'Python', user: user, question: question)
      question.update(right_answer_id: answer.id)

      question.toggle(:published)
      question.save
      question.reload

      expect(question.published).to eq(false)
    end
  end
end
