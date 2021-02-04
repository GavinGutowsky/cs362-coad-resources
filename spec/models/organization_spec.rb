require 'rails_helper'

RSpec.describe Organization, type: :model do

  describe "attributes" do
    it { is_expected.to respond_to(:agreement_one) }
    it { is_expected.to respond_to(:agreement_two) }
    it { is_expected.to respond_to(:agreement_three) }
    it { is_expected.to respond_to(:agreement_four) }
    it { is_expected.to respond_to(:agreement_five) }
    it { is_expected.to respond_to(:agreement_six) }
    it { is_expected.to respond_to(:agreement_seven) }
    it { is_expected.to respond_to(:agreement_eight) }

    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:phone) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:rejection_reason) }
    it { is_expected.to respond_to(:liability_insurance) }
    it { is_expected.to respond_to(:primary_name) }
    it { is_expected.to respond_to(:secondary_name) }
    it { is_expected.to respond_to(:secondary_phone) }
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:transportation) }
  end

  describe "associations" do
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:tickets) }
    it { is_expected.to have_and_belong_to_many(:resource_categories) }
  end

  describe "validators" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email)
          .is_at_least(1) 
          .is_at_most(255)
          .on(:create) }
    it "must have an email with valid format" do
      organization = Organization.new(
        name: "Fake",
        status: 0,
        phone: 'Fake',
        email: 'fake@gamil.com',
        description: 'Fake',
        rejection_reason: 'Fake',
        liability_insurance: 'Fake',
        primary_name: 'Fake',
        secondary_name: 'Fake',
        secondary_phone: 'Fake',
        title: 'Fake',
        transportation: 0
        )
      expect(organization).to be_valid
      organization.email = 'fa..ke#gmail.com'
      expect(organization).to_not be_valid
    end
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:name)
          .is_at_least(1) 
          .is_at_most(255)
          .on(:create) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_length_of(:description)
          .is_at_most(1020)
          .on(:create) }
  end

  describe "methods" do
    it "updates status attribute to approved" do
      organization = Organization.new(status: 'submitted')
      organization.approve
      expect(organization.status).to eq('approved')
    end

    it "updates status attribute to rejected" do
      organization = Organization.new(status: 'submitted')
      organization.reject
      expect(organization.status).to eq('rejected')
    end

    it "has a default status of submitted" do
      expect(Organization.new.status).to eq('submitted')
    end

    it "has a string representation that is its name" do
      expect(Organization.new(name: 'Fake').to_s).to eq('Fake')
    end
  end

end
