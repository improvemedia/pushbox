class MailContentRendererService < BaseService
  attribute :template, Template
  attribute :user,     User

  def call
    template.body
  end
end
