require 'rails_helper'

RSpec.describe AnnouncementsController do
  let(:user_one) { FactoryBot.create(:user, admin: true) }
  let(:user_two) { FactoryBot.create(:user) }
  let!(:announcement_one) { FactoryBot.create(:announcement, user_id: user_one.id) }
  let!(:announcement_two) { FactoryBot.create(:announcement, user_id: user_two.id) }

  before do
    sign_in user_one
  end

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:index) }

    it 'assigns all announcements into @announcements' do
      expect(assigns(:announcements)).to match_array([announcement_one, announcement_two])
    end
  end

  describe 'GET #show' do
    context 'with valid attributes' do
      before { get :show, params: { id: announcement_one.id } }

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:show) }
    end

    context 'with invalid attributes' do
      before { get :show, params: { id: 0 } }

      it { is_expected.to respond_with(:not_found) }
    end
  end

  describe 'GET #new' do
    before { get :new }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:new) }

    it 'assigns a new announcement to @announcement' do
      expect(assigns(:announcement)).to be_a_new(Announcement)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:announcement_param) { FactoryBot.attributes_for(:announcement, user_id: user_one.id) }
      let(:create_action) { post :create, params: { announcement: announcement_param } }

      it 'shows success message' do
        create_action
        expect(flash[:notice]).to eq(I18n.t('notice.create.success', resource: Announcement.model_name.human))
      end

      it 'creates a new announcement into database' do
        expect { create_action }.to change(Announcement, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:announcement_param) { FactoryBot.attributes_for(:announcement, user_id: user_one.id, title: nil) }
      let(:create_action) { post :create, params: { announcement: announcement_param } }

      it 'shows flash error message' do
        create_action
        expect(flash[:danger]).to eq(I18n.t('notice.create.failed', resource: Announcement.model_name.human))
      end

      it 'does not add a new announcement into database' do
        expect { create_action }.not_to change(Announcement, :count)
      end
    end
  end

  describe 'GET #edit' do
    context 'with valid attibutes' do
      before { get :edit, params: { id: announcement_one.id } }

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:edit) }
    end

    context 'with invalid attibutes' do
      before { get :edit, params: { id: 0 } }

      it { is_expected.to respond_with(:not_found) }
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      let(:new_params) { FactoryBot.attributes_for(:announcement, user_id: user_one.id, title: 'New Title') }
      before { patch :update, params: { id: announcement_one.id, announcement: new_params } }

      it 'redirect to announcement path' do
        expect(response).to redirect_to(announcement_path(announcement_one.id))
      end

      it 'checks for updated announcement_one full_name' do
        announcement_one.reload
        expect(announcement_one.title).to eq('New Title')
      end
    end

    context 'with invalid attributes' do
      let(:new_params) { FactoryBot.attributes_for(:announcement, user_id: user_one.id, title: nil) }
      before { patch :update, params: { id: announcement_one.id, announcement: new_params } }

      it { is_expected.to render_template(:edit) }

      it 'shows error message' do
        expect(flash[:danger]).to eq(I18n.t('notice.update.failed', resource: Announcement.model_name.human))
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid attributes' do
      let(:delete_action) { delete :destroy, params: { id: announcement_one.id } }

      it 'a announcement deleted from database' do
        expect { delete_action }.to change(Announcement, :count).by(-1)
      end
    end

    context 'with invalid attributes' do
      let(:delete_action) { delete :destroy, params: { id: 0 } }

      it 'shows flash error message' do
        delete_action
        expect(flash[:danger]).to eq("Couldn't find Announcement with 'id'=0")
      end

      it 'does not delete announcement from database' do
        expect { delete_action }.to_not change(Announcement, :count)
      end
    end
  end
end
