require 'rails_helper'

RSpec.describe Announcement do
  let(:user) { FactoryBot.create(:user) }
  let(:announcement) { FactoryBot.create(:announcement, user_id: user.id) }

  it 'has a valid patient factory' do
    expect(announcement).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'associations' do
    it { is_expected.to belong_to :user }
  end
end
