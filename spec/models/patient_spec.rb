require 'rails_helper'

RSpec.describe Patient do
  let(:user) { FactoryBot.create(:user) }
  let(:facility) { FactoryBot.create(:facility, user_id: user.id) }
  let(:patient) { FactoryBot.create(:patient, facility_id: facility.id) }

  it 'has a valid patient factory' do
    expect(patient).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:cid) }
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to validate_presence_of(:joining_date) }
    it { is_expected.to validate_presence_of(:release_date) }
    it { is_expected.to validate_presence_of(:diseases) }
  end

  describe 'associations' do
    it { is_expected.to belong_to :facility }
    it { is_expected.to have_many(:transfers) }
  end
end
