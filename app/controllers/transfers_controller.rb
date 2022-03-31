class TransfersController < ApplicationController
  load_and_authorize_resource

  def show
    unless @transfer.blank?
      transfer = Transfer.find(params['id'])
      Patient.find(transfer.patient_id).update!(facility_id: transfer.to_facility)
      flash[:notice] = 'Approved for the New Facility'
      @transfer.destroy!
      redirect_to user_transfers_approve_path(current_user.id)
    end 
  end

  def new; end

  def create
    @transfer.date = Date.today
    if @transfer.save
      flash[:notice] = I18n.t('notice.create.success', resource: Transfer.model_name.human)
      redirect_to root_path
    else
      flash[:danger] = I18n.t('notice.create.failed', resource: Transfer.model_name.human)
      render('new')
    end
  end

  def edit; end

  def update
    if @transfer.update(transfer_params)
      flash[:notice] = I18n.t('notice.update.success', resource: Transfer.model_name.human)
      redirect_to transfer_path(@transfer.id)
    else
      flash[:danger] = I18n.t('notice.update.failed', resource: Transfer.model_name.human)
      render('edit')
    end
  end

  def approve
    @transfer = Transfer.where(to_facility: current_user.facilities.ids)
  end

  def destroy
    @transfer.destroy!
    flash[:notice] = 'Request has been removed'
    redirect_to facilities_path
  end

  private

  def transfer_params
    params.require(:transfer).permit(:to_facility, :patient_id)
  end
end
