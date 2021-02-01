require 'rails_helper'

RSpec.describe Region, type: :model do

  it "has a name" do
    expect(Region.new).to respond_to(:name)
  end

end
