require 'spec_helper'

feature 'adding beats as an admin' do

  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user) }

  scenario 'admin can add a new beat' do
    admin_beats
    expect(page).to have_content('Add a new beat')
  end

  scenario "if not an admin you can't visit the beats page" do
    sign_in_as user
    expect(page).to_not have_content('Add a new beat')
  end

  scenario 'an admin can add beats from the beats page' do
    admin_beats
    click_on 'Add a new beat'
    expect(current_path).to eql(new_admin_beat_path)
  end

  def admin_beats
    sign_in_as admin
    visit admin_beats_path
  end

end
