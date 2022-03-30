require 'rails_helper'

RSpec.describe User do
  let!(:user) { FactoryBot.create(:user) }

  it 'has a valid user factory' do
    expect(user).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:facilities) }
    it { is_expected.to have_many(:announcements) }
  end
end
