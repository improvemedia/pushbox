class ContentRenderService < BaseService
  attribute :content, Template
  attribute :data,    Hash

  def call
    normalized_result
  end

  private

  def normalized_result
    render.strip
  end

  def render
    template.render(normalized_data, { strict_variables: true })
  end

  def normalized_data
    data.deep_stringify_keys
  end


  def template
    Liquid::Template.parse(content)
  end
  memoize :template
end
