require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  describe "attributes" do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:active) }
  end

  describe "associations" do
    it { is_expected.to have_and_belong_to_many(:organizations) }
    it { is_expected.to have_many(:tickets) }
  end

  describe "validators" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name)
          .is_at_least(1) 
          .is_at_most(255)
          .on(:create) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe "methods" do
    it "finds or creates an object with name unspecified" do
      expect(ResourceCategory.unspecified.name).to eq('Unspecified')
    end

    it "can be activated" do
      rc = ResourceCategory.new(active: false)
      rc.activate
      expect(rc.active).to be_truthy
    end

    it "can be deactivated" do
      rc = ResourceCategory.new(active: true)
      rc.deactivate
      expect(rc.active).to be_falsy
    end

    it "is inactive when its active attribute is set to false" do
      rc = ResourceCategory.new(active: false)
      expect(rc.inactive?).to be_truthy
      rc.active = true
      expect(rc.inactive?).to be_falsy
    end

    it "has a string representation that is its name" do
      expect(ResourceCategory.new(name: 'Fake').to_s).to eq('Fake')
    end
  end

end
