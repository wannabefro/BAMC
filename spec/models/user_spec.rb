require 'spec_helper'

describe User do

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should have_many(:tracks) }
  it { should have_many(:user_beats) }


end
