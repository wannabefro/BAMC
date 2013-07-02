require 'spec_helper'

feature 'adding beats as an admin' do

  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user) }

  scenario 'visiting the beats page as an admin' do
    sign_in_as admin
    visit beats_path
    expect(current_path).to eql(beats_path)
  end

  scenario "if not an admin you can't visit the beats page" do
    sign_in_as user
    visit beats_path
    expect(current_path).to eql(root_path)
  end

  scenario 'an admin can add beats from the beats page' do
    admin_beats
    click_on 'Add beats'
    expect(current_path).to eql(new_beat_path)
  end

  def admin_beats
    sign_in_as admin
    visit beats_path
  end

end
