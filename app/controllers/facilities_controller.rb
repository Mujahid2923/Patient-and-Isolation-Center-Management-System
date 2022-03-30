class FacilitiesController < ApplicationController
  load_and_authorize_resource

  def index
    @facilities = Facility.page(params[:page]).per(5)
  end

  def show; end

  def new; end

  def create
    @facility.user_id = current_user.id

    if @facility.save
      flash[:notice] = I18n.t('notice.create.success', resource: Facility.model_name.human)
      redirect_to facilities_path
    else
      flash[:danger] = I18n.t('notice.create.failed', resource: Facility.model_name.human)
      render('new')
    end
  end

  def edit; end

  def update
    if @facility.update(facility_params)
      flash[:notice] = I18n.t('notice.update.success', resource: Facility.model_name.human)
      redirect_to facility_path(@facility.id)
    else
      flash[:danger] = I18n.t('notice.update.failed', resource: Facility.model_name.human)
      render('edit')
    end
  end

  def destroy
    @facility.destroy!
    flash[:notice] =
      I18n.t('notice.delete.success', resource: Facility.model_name.human, name: @facility.name)
    redirect_to facilities_path
  end

  private

  def facility_params
    params.require(:facility).permit(:name)
  end
end
