# frozen_string_literal: true

class MailingsController < ApplicationController
  def index
    @presenter = presenter
  end

  def new
    @presenter = presenter
  end

  def create
    form = MailingForm.new(create_params)

    if form.save
      redirect_to mailings_path, notice: "Рассылка создана"
    else
      render :new, locals: { presenter: presenter_for(:new, create_params) }
    end
  end

  def destroy
    mailing = Mailing.actual.find(params[:id])
    mailing.mark_as_deleted

    redirect_to mailings_path, notice: t("common.success")
  end

  private

  def index_params
    {}
  end

  def create_params
    params
      .require(:mailing)
      .permit(:title, :start_at, :template_id, :segment_id)
      .merge(mailing: Mailing.new)
  end
end
