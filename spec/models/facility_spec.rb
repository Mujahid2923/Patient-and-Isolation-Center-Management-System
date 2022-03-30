require 'rails_helper'

RSpec.describe Facility do
  let(:user) { FactoryBot.create(:user) }
  let(:facility) { FactoryBot.create(:facility, user_id: user.id) }

  it 'has a valid patient factory' do
    expect(facility).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:patients) }
    it { is_expected.to belong_to :user }
  end
end
