require 'rails_helper'

RSpec.describe Transfer do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:transfered_facility) }
    it { is_expected.to validate_presence_of(:date) }
  end

  describe 'associations' do
    it { is_expected.to belong_to :patient }
  end
end
