require 'rails_helper'

RSpec.describe Invitation do
  let(:user) { FactoryBot.create(:user) }
  let(:invitation) { FactoryBot.create(:invitation) }

  it 'has a valid patient factory' do
    expect(invitation).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.not_to allow_value('hello@world').for(:email) }
    it { is_expected.to allow_value('user@website.com').for(:email) }
  end
end
