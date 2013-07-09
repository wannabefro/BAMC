# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :track do
    beat_id 1
    user_id 1
    track "hippidy.wav"
    name "Hiphopapotamous"
  end
end
