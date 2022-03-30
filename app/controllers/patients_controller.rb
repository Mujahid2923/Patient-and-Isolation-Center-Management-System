class PatientsController < ApplicationController
  load_and_authorize_resource

  def index
    @patients = Patient.page(params[:page]).per(5)
  end

  def show; end

  def new; end

  def create
    if @patient.save
      flash[:notice] = I18n.t('notice.create.success', resource: Patient.model_name.human)
      redirect_to patients_path
    else
      flash[:danger] = I18n.t('notice.create.failed', resource: Patient.model_name.human)
      render('new')
    end
  end

  def edit; end

  def update
    pre_facility_id = @patient.facility_id
    curr_facility_id = patient_params['facility_id'].to_i

    if @patient.update(patient_params)
      flash[:notice] = I18n.t('notice.update.success', resource: Patient.model_name.human)

      if curr_facility_id > 0 && pre_facility_id != curr_facility_id
        Transfer.create(transfered_facility: Facility.find(curr_facility_id).name, date: Date.today,
                        patient_id: @patient.id)
      end

      redirect_to patient_path(@patient.id)
    else
      flash[:danger] = I18n.t('notice.update.failed', resource: Patient.model_name.human)
      render('edit')
    end
  end

  def destroy
    @patient.destroy!
    flash[:notice] =
      I18n.t('notice.delete.success', resource: Patient.model_name.human, name: @patient.name)
    redirect_to patients_path
  end

  def list
    @patients_list = Facility.find(params[:facility_id]).patients.page(params[:page]).per(5)
  end

  def active
    @active_patients_list = Facility.find(params[:facility_id]).patients.where(active: 1)
  end

  def recovered
    @recoverd_patients_list = Facility.find(params[:facility_id]).patients.where(active: 0)
  end

  def transfered
    @transfered_list = Transfer.where(transfered_facility: Facility.find(params[:facility_id]).name)
  end

  private

  def patient_params
    params.require(:patient).permit(
      :name,
      :cid,
      :phone_number,
      :joining_date,
      :release_date,
      :diseases,
      :facility_id,
      :image,
      :active
    )
  end
end
