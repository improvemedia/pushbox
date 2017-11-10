
class UserDecorator < BaseDecorator

  def render_data
    { first_name: object.first_name }
  end
end
