require 'rails_helper'

RSpec.describe InvitationsController do
  let(:user) { FactoryBot.create(:user) }
  let!(:invitation) { FactoryBot.create(:invitation) }

  before do
    sign_in user
  end


  describe 'GET #new' do
    before { get :new }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:new) }

    it 'assigns a new invitation to @invitation' do
      expect(assigns(:invitation)).to be_a_new(Invitation)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:invitation_param) { FactoryBot.attributes_for(:invitation) }
      let(:create_action) { post :create, params: { invitation: invitation_param } }

      it 'shows success message' do
        create_action
        expect(flash[:notice]).to eq(I18n.t('notice.create.success', resource: Invitation.model_name.human))
      end

      it 'creates a new invitation into database' do
        expect { create_action }.to change(Invitation, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:invitation_param) { FactoryBot.attributes_for(:invitation, email: nil) }
      let(:create_action) { post :create, params: { invitation: invitation_param } }

      it 'shows flash error message' do
        create_action
        expect(flash[:danger]).to eq(I18n.t('notice.create.failed', resource: Invitation.model_name.human))
      end

      it 'does not add a new invitation into database' do
        expect { create_action }.not_to change(Invitation, :count)
      end
    end
  end
end
