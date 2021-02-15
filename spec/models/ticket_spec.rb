require 'rails_helper'

RSpec.describe Ticket, type: :model do

  describe "attributes" do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:phone) }
    it { is_expected.to respond_to(:closed)}
    it { is_expected.to respond_to(:closed_at) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:region) }
    it { is_expected.to belong_to(:resource_category) }
    it { is_expected.to belong_to(:organization).optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name)
          .is_at_least(1) 
          .is_at_most(255)
          .on(:create) }
    it { is_expected.to validate_length_of(:description)
          .is_at_most(1020)
          .on(:create) }
    it "must have a plausibly valid phone number" do
      ticket = create(:ticket)
      expect(ticket).to be_valid
      ticket.phone = "5413308612"
      expect(ticket).to_not be_valid
    end
  end

  describe "methods" do
    it "is open when its closed attribute is false" do
      ticket = build(:ticket)
      expect(ticket.open?).to be_truthy
      ticket.closed = true
      expect(ticket.open?).to be_falsy
    end

    it "is captured when it belongs to an organization" do
      ticket = build(:ticket)
      expect(ticket.captured?).to be_falsy
      ticket.organization = Organization.new
      expect(ticket.captured?).to be_truthy
    end

    it "has a string representation its id" do
      expect(Ticket.new(id: 3).to_s).to eq("Ticket 3")
    end
  end

end
