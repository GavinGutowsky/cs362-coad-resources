require 'rails_helper'

RSpec.describe User, type: :model do

  it "has an email" do
    expect(User.new).to respond_to(:email)
  end

  it "has a role" do
    expect(User.new).to respond_to(:role)
  end

  it "belongs to an organization" do
    expect(User.new).to belong_to(:organization).optional
  end

  describe "validators" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email)
          .is_at_least(1) 
          .is_at_most(255)
          .on(:create) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it "must have an email with valid format" do
      user = User.new(
        email: "user@gmail.com",
        role: 0,
        password: 'FakePassword'
        )
      expect(user).to be_valid
      user.email = "us..er#gmail.com"
      expect(user).to_not be_valid
    end

    it { is_expected.to validate_presence_of(:password).on(:create) }
    it { is_expected.to validate_length_of(:password) 
          .is_at_least(7) 
          .is_at_most(255)
          .on(:create) }
  end

end
