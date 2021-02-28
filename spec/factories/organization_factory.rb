FactoryBot.define do
  factory :organization do
  sequence(:name) { |n| "Fake Organization #{n}" }
  status { :submitted }
  phone { '541-330-8612' }
  secondary_phone { '541-331-8612' }
  sequence(:email) { |n| "fake#{n}@email.com" }
  description { 'Fake description' }
  rejection_reason { 'Fake reason' }
  liability_insurance { true }
  primary_name { 'Fake primary name' }
  secondary_name { 'Fake secondary name' }
  title { 'Fake title' }
  transportation { :yes }
  end
end