require 'spec_helper'

describe Track do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:beat) }

  it { should belong_to(:user) }
  it { should belong_to(:beat) }
end
