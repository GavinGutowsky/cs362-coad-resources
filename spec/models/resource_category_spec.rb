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

end
