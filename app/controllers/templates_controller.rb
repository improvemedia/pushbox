# frozen_string_literal: true

class TemplatesController < ApplicationController
  def index
    @presenter = presenter
  end

  def preview
    @presenter = presenter
  end

  def new
    @presenter = presenter
  end

  def edit
    @presenter = presenter
  end

  def create
    form = TemplateForm.new(create_params)

    if form.save
      redirect_to action: :index, notice: "Шаблон создан"
    else
      render :new, locals: { presenter: presenter_for(:new, create_params) }
    end
  end

  def update
    form = TemplateForm.new(update_params)
    if form.save
      redirect_to edit_template_path(form.template), notice: t("common.success")
    else
      render :edit, locals: { presenter: presenter_for(:edit, update_params) }
    end
  end

  def destroy
    template.mark_as_deleted

    redirect_to templates_path, notice: t("common.success")
  end

  private

  def template
    Template.actual.find(params[:id])
  end
  memoize :template

  def show_params
    {}
  end

  def create_params
    form_params.merge(template: Template.new)
  end

  def update_params
    form_params.merge(template: template)
  end

  def new_params
    {}
  end

  def edit_params
    { template: template }
  end

  def preview_params
    { template: template }
  end

  def form_params
    params.require(:template).permit(:title, :body)
  end
end
