require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  it "has a name" do
    expect(ResourceCategory.new).to respond_to(:name)
  end

  it "has an active attribute" do
    expect(ResourceCategory.new).to respond_to(:active)
  end

  it "has and belongs to many organizations" do
    expect(ResourceCategory.new).to have_and_belong_to_many(:organizations)
  end

  it "has many tickets" do
    expect(ResourceCategory.new).to have_many(:tickets)
  end

end
