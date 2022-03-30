class AnnouncementsController < ApplicationController
  load_and_authorize_resource

  def index
    @announcements = Announcement.page(params[:page]).per(3)
  end

  def show; end

  def new; end

  def create
    @announcement.user_id = current_user.id

    if @announcement.save
      flash[:notice] = I18n.t('notice.create.success', resource: Announcement.model_name.human)
      redirect_to announcements_path
    else
      flash[:danger] = I18n.t('notice.create.failed', resource: Announcement.model_name.human)
      render('new')
    end
  end

  def edit; end

  def update
    if @announcement.update(announcement_params)
      flash[:notice] = I18n.t('notice.update.success', resource: Announcement.model_name.human)
      redirect_to announcement_path(@announcement.id)
    else
      flash[:danger] = I18n.t('notice.update.failed', resource: Announcement.model_name.human)
      render('edit')
    end
  end

  def destroy
    @announcement.destroy!
    flash[:notice] =
      I18n.t('notice.delete.success', resource: Announcement.model_name.human, name: @announcement.title)
    redirect_to announcements_path
  end

  private

  def announcement_params
    params.require(:announcement).permit(
      :title,
      :description,
      :image
    )
  end
end
