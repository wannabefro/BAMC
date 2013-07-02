require 'spec_helper'

feature 'adding beats as an admin' do

  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user) }

  scenario 'admin can add a new beat' do
    admin_beats
    expect(page).to have_content('Add a new beat')
    click_link 'Add a new beat'
    expect(current_path).to eql(new_admin_beat_path)
  end

  scenario 'user does not have link to add a new beat' do
    sign_in_as user
    expect(page).to_not have_content('Add a new beat')
  end

  scenario 'user cannot go to new admin beats path' do
    sign_in_as user
    visit new_admin_beat_path
    expect(page).to have_content('You are not authorized!')
  end

  def admin_beats
    sign_in_as admin
    visit admin_beats_path
  end

end
