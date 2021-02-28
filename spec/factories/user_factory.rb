FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "fake#{n}@email.com" }
    role { :organization }
    password { 'fakepassword' }

    trait :organization do
      organization
    end

    trait :admin do
      role { :admin }
    end
  end
end