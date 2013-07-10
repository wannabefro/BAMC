require 'spec_helper'

describe Track do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:beat) }

  it { should belong_to(:user) }
  it { should belong_to(:beat) }

  let!(:user) {FactoryGirl.create(:user)}
  let!(:beat) {FactoryGirl.create(:beat)}
  let(:tracks) {FactoryGirl.create_list(:track, 5, user: user, beat: beat)}
  it 'a user can only have 5 beats' do
    tracks
    track = FactoryGirl.build(:track, user: user)
    expect(track).to_not be_valid
  end
end
