require 'spec_helper'

describe Beat do

  it { should validate_presence_of(:beat) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:genre) }
  it { should validate_presence_of(:name) }

end
