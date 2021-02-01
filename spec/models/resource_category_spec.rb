require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  it "has a name" do
    expect(ResourceCategory.new).to respond_to(:name)
  end

  it "has an active attribute" do
    expect(ResourceCategory.new).to respond_to(:active)
  end

end
