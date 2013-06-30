FactoryGirl.define do
  factory :user do
    username 'Billy'
    password 'password'
    password_confirmation 'password'
    email 'billy@bill.com'
    admin false

    factory :admin do
      username 'Mr Admin'
      password 'password'
      password_confirmation 'password'
      email 'ima@admin.com'
      admin true
    end
  end
end
