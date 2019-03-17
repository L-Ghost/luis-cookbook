FactoryBot.define do
  factory :user do
    # default email
    sequence(:email) {|i| "email#{i}@cookbook.com"}
    # random password
    password { 8.times.map{ Random.rand(10) }.join }
  end
end