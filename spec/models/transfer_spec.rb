require 'rails_helper'

RSpec.describe Transfer do
  let(:user) { FactoryBot.create(:user) }
  let(:facility) { FactoryBot.create(:facility, user_id: user.id) }
  let(:patient) { FactoryBot.create(:patient, facility_id: facility.id) }
  let(:transfer) { FactoryBot.create(:transfer, to_facility: facility.id, patient_id: patient.id) }

  it 'has a valid patient' do
    expect(transfer).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:to_facility) }
    it { is_expected.to validate_presence_of(:date) }
  end
end
