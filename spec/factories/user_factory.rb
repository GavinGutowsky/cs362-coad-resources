FactoryBot.define do
  factory :user do
    email { 'fake@email.com' }
    role { :organization }
    password { 'fakepassword' }
  end
end