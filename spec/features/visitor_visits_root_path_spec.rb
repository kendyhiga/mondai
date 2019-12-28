require 'rails_helper'

feature 'visitor visits root path' do
  scenario 'successfully' do
    visit root_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Mondai')
    expect(page).to have_link('Login')
  end
end
