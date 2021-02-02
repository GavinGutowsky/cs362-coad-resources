require 'rails_helper'

RSpec.describe Ticket, type: :model do

  it "has a name" do
    expect(Ticket.new).to respond_to(:name)
  end

  it "has a description" do
    expect(Ticket.new).to respond_to(:description)
  end

  it "has a phone" do
    expect(Ticket.new).to respond_to(:phone)
  end

  it "has a closed attribute" do
    expect(Ticket.new).to respond_to(:closed)
  end

  it "has a closed_at attribute" do
    expect(Ticket.new).to respond_to(:closed_at)
  end

  it "belongs to a region" do
    expect(Ticket.new).to belong_to(:region)
  end

  it "belongs to a resource_category" do
    expect(Ticket.new).to belong_to(:resource_category)
  end

  it "belongs to a organization" do
    expect(Ticket.new).to belong_to(:organization).optional
  end

end
