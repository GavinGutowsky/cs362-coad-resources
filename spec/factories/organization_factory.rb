FactoryBot.define do
  factory :organization do
  name { 'Fake' }
  status { 'approved' }
  phone { '541-330-8612' }
  email { 'fake@email.com' }
  description { 'Fake description' }
  rejection_reason { 'Fake reason' }
  liability_insurance { true }
  primary_name { 'Fake primary name' }
  secondary_name { 'Fake secondary name' }
  title { 'Fake title' }
  transportation { :yes }
  end
end