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
    it "has a valid email format" do
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      user = User.new
      user.email = "User@gmail.com"
      expect(user.email).to match(VALID_EMAIL_REGEX)
      user.email = "us..er#gmail.com"
      expect(user.email.match(VALID_EMAIL_REGEX)).to be_falsy
    end

    it { is_expected.to validate_presence_of(:password).on(:create) }
    it { is_expected.to validate_length_of(:password) 
          .is_at_least(7) 
          .is_at_most(255)
          .on(:create) }
  end

end
