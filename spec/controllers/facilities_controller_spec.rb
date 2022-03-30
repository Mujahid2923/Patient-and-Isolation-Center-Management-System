require 'rails_helper'

RSpec.describe FacilitiesController do
  let(:user_one) { FactoryBot.create(:user) }
  let(:user_two) { FactoryBot.create(:user) }
  let!(:facility_one) { FactoryBot.create(:facility, user_id: user_one.id) }
  let!(:facility_two) { FactoryBot.create(:facility, user_id: user_two.id) }

  before do
    sign_in user_one
  end

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:index) }

    it 'assigns all facilities into @facilities' do
      expect(assigns(:facilities)).to match_array([facility_one, facility_two])
    end
  end

  describe 'GET #show' do
    context 'with valid attributes' do
      before { get :show, params: { id: facility_one.id } }

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

    it 'assigns a new facility to @facility' do
      expect(assigns(:facility)).to be_a_new(Facility)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:facility_param) { FactoryBot.attributes_for(:facility) }
      let(:create_action) { post :create, params: { facility: facility_param } }

      it 'shows success message' do
        create_action
        expect(flash[:notice]).to eq(I18n.t('notice.create.success', resource: Facility.model_name.human))
      end

      it 'creates a new facility into database' do
        expect { create_action }.to change(Facility, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:facility_param) { FactoryBot.attributes_for(:facility, name: nil) }
      let(:create_action) { post :create, params: { facility: facility_param } }

      it 'shows flash error message' do
        create_action
        expect(flash[:danger]).to eq(I18n.t('notice.create.failed', resource: Facility.model_name.human))
      end

      it 'does not add a new facility into database' do
        expect { create_action }.not_to change(Facility, :count)
      end
    end
  end

  describe 'GET #edit' do
    context 'with valid attibutes' do
      before { get :edit, params: { id: facility_one.id } }

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
      let(:new_params) { FactoryBot.attributes_for(:facility, name: 'New Name') }
      before { patch :update, params: { id: facility_one.id, facility: new_params } }

      it 'redirect to facility path' do
        expect(response).to redirect_to(facility_path(facility_one.id))
      end

      it 'checks for updated facility_one full_name' do
        facility_one.reload
        expect(facility_one.name).to eq('New Name')
      end
    end

    context 'with invalid attributes' do
      let(:new_params) { FactoryBot.attributes_for(:facility, name: nil) }
      before { patch :update, params: { id: facility_one.id, facility: new_params } }

      it { is_expected.to render_template(:edit) }

      it 'shows error message' do
        expect(flash[:danger]).to eq(I18n.t('notice.update.failed', resource: Facility.model_name.human))
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid attributes' do
      let(:delete_action) { delete :destroy, params: { id: facility_one.id } }

      it 'a facility deleted from database' do
        expect { delete_action }.to change(Facility, :count).by(-1)
      end
    end

    context 'with invalid attributes' do
      let(:delete_action) { delete :destroy, params: { id: 0 } }

      it 'shows flash error message' do
        delete_action
        expect(flash[:danger]).to eq("Couldn't find Facility with 'id'=0")
      end

      it 'does not delete facility from database' do
        expect { delete_action }.to_not change(Facility, :count)
      end
    end
  end
end
