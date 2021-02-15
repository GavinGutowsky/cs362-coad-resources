FactoryBot.define do
  factory :ticket do
    name { 'Fake' }
    description { 'Fake description' }
    phone { '+1 541-330-8612' }
    closed { true }
    region 
    resource_category 
  end

  trait :closed do
    closed { true }
  end

  trait :open do
    closed { false }
  end
end