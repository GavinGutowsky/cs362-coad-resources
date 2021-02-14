FactoryBot.define do
  factory :ticket do
    name { 'Fake' }
    description { 'Fake description' }
    phone { '541-330-8612' }
    closed { true }
  end

  trait :closed do
    closed: true
  end

  trait :open do
    closed: false
  end
end