# frozen_string_literal: true

class BaseForm
  include Virtus.model
  include ActiveModel::Model
  include WithHelperAndRoutingConcern

  extend Memoist

  InvalidError = Class.new(StandardError)

  class << self
    # rubocop:disable Metrics/MethodLength
    def delegate_attributes(*attrs)
      options = attrs.extract_options!
      unless options.key?(:to)
        raise ArgumentError,
              "Delegation needs a target. " \
              "Supply an options hash with a :to key as the last argument " \
              "(e.g. delegate :hello, to: :greeter)."
      end

      target    = options[:to]
      delegator = Module.new

      delegator.class_eval do
        attrs.each do |attr|
          define_method(attr.to_s) do
            value_without_delegation = super()

            if value_without_delegation.nil?
              public_send(target).public_send(attr)
            else
              value_without_delegation
            end
          end
        end
      end
      prepend delegator
    end
    # rubocop:enable Metrics/MethodLength

    def form_name(name)
      define_singleton_method :model_name do
        ActiveModel::Name.new(Object, nil, name.to_s.underscore)
      end
    end

    def attribute_names
      attribute_set.map(&:name)
    end
  end

  def persisted?
    false
  end

  def save
    if valid?
      persist
    else
      false
    end
  end

  def save!
    raise InvalidError unless valid?

    persist!
  end

  def persist!
    raise NotImplementedError
  end
end
