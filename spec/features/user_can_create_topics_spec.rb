require 'rails_helper'

feature 'user can create topics' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: 123456)

    login_as user
    visit root_path
    click_on 'Topics'
    click_on 'Create topic'
    fill_in 'Name', with: 'Development'
    click_on 'Create'

    expect(current_path).to eq(topics_path)
    expect(page).to have_content('Topic created successfully')
    expect(page).to have_content('Development')
  end

  scenario 'and topic name cant be blank' do
    user = User.create!(email: 'user@email.com', password: 123456)

    login_as user
    visit root_path
    click_on 'Topics'
    click_on 'Create topic'
    fill_in 'Name', with: ''
    click_on 'Create'

    expect(current_path).to eq(topics_path)
    expect(page).to have_content("Name can't be blank")
  end

  scenario 'and topic name must be unique' do
    user = User.create!(email: 'user@email.com', password: 123456)
    Topic.create!(name: 'Development')

    login_as user
    visit root_path
    click_on 'Topics'
    click_on 'Create topic'
    fill_in 'Name', with: 'Development'
    click_on 'Create'

    expect(current_path).to eq(topics_path)
    expect(page).to have_content("Name has already been taken")
  end

  scenario 'and topic name uniqueness must not be case sensitive' do
    user = User.create!(email: 'user@email.com', password: 123456)
    Topic.create!(name: 'Development')

    login_as user
    visit root_path
    click_on 'Topics'
    click_on 'Create topic'
    fill_in 'Name', with: 'development'
    click_on 'Create'

    expect(current_path).to eq(topics_path)
    expect(page).to have_content("Name has already been taken")
  end
end
