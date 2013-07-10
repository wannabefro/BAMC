require 'spec_helper'

feature 'dashboard contains my beats and my tracks' do

  scenario 'guests cannot access dashboard' do
    visit dashboard_index_path
    expect(page).to have_content('You are not authorized!')
  end

end
