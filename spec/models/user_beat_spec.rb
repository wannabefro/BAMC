require 'spec_helper'

describe UserBeat do

  describe "associations" do
    it { should belong_to(:user) }
  end
end
