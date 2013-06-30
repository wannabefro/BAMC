# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :beat do
    price "0.99"
    name "Epic Beat"
    beat_url "amazon.com/beat/12345"
    genre "beat"
  end
end
