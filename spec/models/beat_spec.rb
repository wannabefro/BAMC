require 'spec_helper'

describe Beat, focus: true do
  GENRE = ['Old School', 'Pop', 'Alternative', 'Reggae', 'Underground', 'Jazzy', 'R&B']

  it { should validate_presence_of(:beat) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:genre) }
  it { should validate_presence_of(:name) }
  it { should ensure_inclusion_of(:genre).in_array(GENRE)}

end
