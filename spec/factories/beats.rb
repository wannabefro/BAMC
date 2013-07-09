# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :beat do
    price "0.99"
    name "Epic Beat"
    beat_file_name 'hiphop.mp3'
    beat_content_type 'audio/mp3'
    beat_file_size 837248
    genre "Pop"
  end
end
