require 'rails_helper'

RSpec.describe Ticket, type: :model do

  describe 'attributes' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:phone) }
    it { is_expected.to respond_to(:closed)}
    it { is_expected.to respond_to(:closed_at) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:region) }
    it { is_expected.to belong_to(:resource_category) }
    it { is_expected.to belong_to(:organization).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name)
          .is_at_least(1) 
          .is_at_most(255)
          .on(:create) }
    it { is_expected.to validate_length_of(:description)
          .is_at_most(1020)
          .on(:create) }
    it 'must have a plausibly valid phone number' do
      ticket = create(:ticket)
      expect(ticket).to be_valid
      ticket.phone = '5413308612'
      expect(ticket).to_not be_valid
    end
  end

  describe 'scopes' do
    let(:closed_ticket) { create(:ticket, :closed) }
    let(:closed_organization_ticket) { create(:ticket, :closed, :organization) }
    let(:open_ticket) { create(:ticket, :open) }
    let(:open_nil_ticket) { create(:ticket, :open, :nil_organization) }
    let(:open_organization_ticket) { create(:ticket, :open, :organization) }

    describe 'open' do
      it 'contains open tickets not belonging to an organization' do
        expect(Ticket.open).to include(open_nil_ticket)
      end

      it 'does not contain open tickets belonging to an organization' do
        expect(Ticket.open).to_not include(open_organization_ticket)
      end
      
      it 'does not contain closed tickets' do
        expect(Ticket.open).to_not include(closed_ticket)
      end
    end

    describe 'closed' do
      it 'contains closed tickets' do
        expect(Ticket.closed).to include(closed_ticket)
      end
      
      it 'does not contain open tickets' do
        expect(Ticket.closed).to_not include(open_ticket)
      end
    end

    describe 'all_organization' do
      it 'contains all open tickets belonging to an organization' do
        expect(Ticket.all_organization).to include(open_organization_ticket)
      end

      it 'does not contain closed tickets' do
        expect(Ticket.all_organization).to_not include(closed_ticket)
      end

      it 'does not contain open tickets not belonging to an organization' do
        expect(Ticket.all_organization).to_not include(open_nil_ticket)
      end
    end

    describe 'organization' do
      it 'contains open tickets belonging to a given organization' do
        organization = open_organization_ticket.organization
        expect(Ticket.organization(organization.id)).to include(open_organization_ticket)
      end

      it 'does not contain closed tickets belonging to a given organization' do
        organization = closed_organization_ticket.organization
        expect(Ticket.organization(organization.id)).to_not include(closed_organization_ticket)
      end
      
      it 'does not contain tickets not belonging to a given organization' do
        organization = open_organization_ticket.organization
        expect(Ticket.organization(organization.id)).to_not include(open_ticket)
      end
    end

    describe 'closed_organization' do
      it 'contains closed tickets belonging to a given organization' do
        organization = closed_organization_ticket.organization
        expect(Ticket.closed_organization(organization.id)).to include(closed_organization_ticket)
      end

      it 'does not contain open tickets belonging to a given organization' do
        organization = open_organization_ticket.organization
        expect(Ticket.closed_organization(organization.id)).to_not include(open_organization_ticket)
      end
      
      it 'does not contain tickets not belonging to a given organization' do
        organization = closed_organization_ticket.organization
        expect(Ticket.closed_organization(organization.id)).to_not include(closed_ticket)
      end
    end

    describe 'region' do
      it 'contains tickets belonging to a given region' do
        region = open_ticket.region
        expect(Ticket.region(region.id)).to include(open_ticket)
      end

      it 'does not contain tickets not belonging to a given region' do
        region = open_ticket.region
        expect(Ticket.region(region.id)).to_not include(closed_ticket)
      end
    end

    describe 'resource_category' do
      it 'contains tickets belonging to a given resource_category' do
        resource_category = open_ticket.resource_category
        expect(Ticket.resource_category(resource_category.id)).to include(open_ticket)
      end

      it 'does not contain tickets not belonging to a given resource_category' do
        resource_category = open_ticket.resource_category
        expect(Ticket.resource_category(resource_category.id)).to_not include(closed_ticket)
      end
    end
  end

  describe 'methods' do
    it 'is open when its closed attribute is false' do
      ticket = build(:ticket)
      expect(ticket.open?).to be_truthy
      ticket.closed = true
      expect(ticket.open?).to be_falsy
    end

    it 'is captured when it belongs to an organization' do
      ticket = build(:ticket)
      expect(ticket.captured?).to be_falsy
      ticket.organization = Organization.new
      expect(ticket.captured?).to be_truthy
    end

    it 'has a string representation its id' do
      expect(Ticket.new(id: 3).to_s).to eq('Ticket 3')
    end
  end

end
