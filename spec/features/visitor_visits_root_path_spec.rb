require 'rails_helper'

feature 'visitor visits root path' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content('Mondai')
  end
end
