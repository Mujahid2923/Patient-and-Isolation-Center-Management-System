require 'rails_helper'

RSpec.describe PatientsController do
  let(:user) { FactoryBot.create(:user) }
  let(:facility) { FactoryBot.create(:facility, user_id: user.id) }
  let!(:patient_one) { FactoryBot.create(:patient, facility_id: facility.id) }
  let!(:patient_two) { FactoryBot.create(:patient, facility_id: facility.id) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:index) }

    it 'assigns all patients into @patients' do
      expect(assigns(:patients)).to match_array([patient_one, patient_two])
    end
  end

  describe 'GET #show' do
    context 'with valid attributes' do
      before { get :show, params: { id: patient_one.id } }

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

    it 'assigns a new patient to @patient' do
      expect(assigns(:patient)).to be_a_new(Patient)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:facility) { FactoryBot.create(:facility, user_id: user.id) }
      let(:patient_param) { FactoryBot.attributes_for(:patient, facility_id: facility.id) }
      let(:create_action) { post :create, params: { patient: patient_param } }

      it 'shows success message' do
        create_action
        expect(flash[:notice]).to eq(I18n.t('notice.create.success', resource: Patient.model_name.human))
      end

      it 'creates a new patient into database' do
        expect { create_action }.to change(Patient, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:patient_param) { FactoryBot.attributes_for(:patient, name: nil) }
      let(:create_action) { post :create, params: { patient: patient_param } }

      it 'shows flash error message' do
        create_action
        expect(flash[:danger]).to eq(I18n.t('notice.create.failed', resource: Patient.model_name.human))
      end

      it 'does not add a new patient into database' do
        expect { create_action }.not_to change(Patient, :count)
      end
    end
  end

  describe 'GET #edit' do
    context 'with valid attibutes' do
      before { get :edit, params: { id: patient_one.id } }

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
      let(:new_params) { FactoryBot.attributes_for(:patient, name: 'New Name') }
      before { patch :update, params: { id: patient_one.id, patient: new_params } }

      it 'redirect to patient path' do
        # byebug
        expect(response).to redirect_to(patient_path(patient_one.id))
      end

      it 'checks for updated patient_one full_name' do
        patient_one.reload
        expect(patient_one.name).to eq('New Name')
      end
    end

    context 'with invalid attributes' do
      let(:new_params) { FactoryBot.attributes_for(:patient, name: nil) }
      before { patch :update, params: { id: patient_one.id, patient: new_params } }

      it { is_expected.to render_template(:edit) }

      it 'shows error message' do
        expect(flash[:danger]).to eq(I18n.t('notice.update.failed', resource: Patient.model_name.human))
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid attributes' do
      let(:delete_action) { delete :destroy, params: { id: patient_one.id } }

      it 'a patient deleted from database' do
        expect { delete_action }.to change(Patient, :count).by(-1)
      end
    end

    context 'with invalid attributes' do
      let(:delete_action) { delete :destroy, params: { id: 0 } }

      it 'shows flash error message' do
        delete_action
        expect(flash[:danger]).to eq("Couldn't find Patient with 'id'=0")
      end

      it 'does not delete patient from database' do
        expect { delete_action }.to_not change(Patient, :count)
      end
    end
  end
end
