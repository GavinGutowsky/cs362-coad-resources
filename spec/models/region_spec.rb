require 'rails_helper'

RSpec.describe Region, type: :model do

  it "has a name" do
    expect(Region.new).to respond_to(:name)
  end

  it "has many tickets" do
    expect(Region.new).to have_many(:tickets)
  end

end
