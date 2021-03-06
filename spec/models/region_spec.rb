require 'rails_helper'

RSpec.describe Region, type: :model do

  it 'has a name' do
    expect(build(:region)).to respond_to(:name)
  end

  it 'has many tickets' do
    expect(build(:region)).to have_many(:tickets)
  end

  describe 'validators' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name)
          .is_at_least(1) 
          .is_at_most(255)
          .on(:create) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'methods' do
    it 'returns a region named Unspecified' do
      expect(Region.unspecified.name).to eq('Unspecified')
    end

    it 'has a string representation that is its name' do
      expect(build(:region, name: 'Fake Region').to_s).to eq('Fake Region')
    end
  end

end
