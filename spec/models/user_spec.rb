require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has an email' do
    expect(build(:user)).to respond_to(:email)
  end

  it 'has a role' do
    expect(build(:user)).to respond_to(:role)
  end

  it 'belongs to an organization' do
    expect(build(:user)).to belong_to(:organization).optional
  end

  describe 'validators' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email)
          .is_at_least(1) 
          .is_at_most(255)
          .on(:create) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it 'must have an email with valid format' do
      user = build(:user)
      expect(user).to be_valid
      user.email = 'us..er#gmail.com'
      expect(user).to_not be_valid
    end

    it { is_expected.to validate_presence_of(:password).on(:create) }
    it { is_expected.to validate_length_of(:password) 
          .is_at_least(7) 
          .is_at_most(255)
          .on(:create) }
  end

  describe 'methods' do
    it 'has a default role of organization' do
      expect(build(:user).role).to eq('organization')
    end

    it 'has a string representation that is its email' do
      expect(build(:user, email: 'fake@email.com').to_s).to eq('fake@email.com')
    end
  end

end
