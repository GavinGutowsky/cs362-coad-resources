require 'rails_helper'

RSpec.describe User, type: :model do

  it "has an email" do
    expect(User.new).to respond_to(:email)
  end

  it "has a role" do
    expect(User.new).to respond_to(:role)
  end

end
