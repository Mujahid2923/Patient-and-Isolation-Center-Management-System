require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  subject(:ability) { described_class.new(user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe 'when the user is not an admin' do
    let(:user) { FactoryBot.create(:user) }
    let(:own_request) { FactoryBot.create(:facility, user_id: user.id) }
    let(:other_user_request) { FactoryBot.create(:facility, user_id: other_user.id) }

    context 'when authorized' do
      it { is_expected.to be_able_to(:read, User) }
      it { is_expected.to be_able_to(:read, Facility) }
      it { is_expected.to be_able_to(:create, own_request) }
      it { is_expected.to be_able_to(:read, own_request) }
      it { is_expected.to be_able_to(:update, own_request) }
      it { is_expected.to be_able_to(:destroy, own_request) }
    end

    context 'when not authorized' do
      it { is_expected.to_not be_able_to(:create, other_user_request) }
      it { is_expected.to_not be_able_to(:update, other_user_request) }
      it { is_expected.to_not be_able_to(:destroy, other_user_request) }
      it { is_expected.to_not be_able_to(:manage, Announcement) }
      it { is_expected.to_not be_able_to(:manage, Facility) }
    end
  end

  context 'when the user is an admin' do
    let(:user) { FactoryBot.create(:user, admin: true) }

    it { is_expected.to be_able_to(:manage, Announcement) }
    it { is_expected.to be_able_to(:manage, Facility) }
    it { is_expected.to be_able_to(:manage, User) }
  end
end
