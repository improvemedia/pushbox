# encoding: utf-8

# The goal with this base form is to keep the child classes
# as clean as possible

class BaseForm
  include Virtus.model
  include ActiveModel::Validations
  include ActiveModel::ForbiddenAttributesProtection
  include ActiveModel::Model
  include WithHelperAndRoutingConcern

  class InvalidError < StandardError ; end

  extend Memoist

  include WithHelperAndRoutingConcern

  module HasManyAssociation
    extend ActiveSupport::Concern

    protected

    # Determines if a hash contains a truthy _destroy key.
    def has_destroy_flag?(hash)
      ActiveRecord::ConnectionAdapters::Column.value_to_boolean(hash['_destroy'])
    end

    module ClassMethods

      def has_many(name, options = {})
        raise ArgumentError, "association names must be a Symbol" unless name.kind_of?(Symbol)

        klass = extract_class_name(options) || calculate_class_name(name)
        attribute name, Array[klass]

        # This is a requirent in order to get fields_for working in the view.
        define_method "#{name}_attributes=" do |attributes|
          send("#{name}=",[]) unless send(name)
          attributes.each do |k,v|
            obj = klass.new(v)
            send(name) << obj
          end
        end
      end

      def calculate_class_name(name)
        "#{name.to_s.singularize}_form".classify.constantize
      end

      def extract_class_name(options)
        options[:class_name] and options[:class_name].constantize
      end

      def association_class(name)
        if association = attribute_set.detect{ |a| a.name == name }
          association.type.member_type
        end
      end
    end
  end

  include HasManyAssociation

  def initialize(*args, &block)
    sanitize_args args
    super
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
    raise InvalidError if !valid?

    persist!
  end

  def persist!
    raise "Implement me!"
  end

  def self.delegate_attributes(*methods)
    options = methods.extract_options!
    unless options.is_a?(Hash) && to = options[:to]
      raise ArgumentError, 'Delegation needs a target. Supply an options hash with a :to key as the last argument (e.g. delegate :hello, to: :greeter).'
    end


    _module = Module.new

    _module.class_eval do
      methods.each do |method|
        define_method "#{method}" do
          value_without_delegation = super()
          if value_without_delegation.nil?
            send(to).try(method)
          else
            value_without_delegation
          end
        end
      end
    end
    prepend _module

    #methods.each do |method|
      #define_method "#{method}_with_delegation" do
        #value_without_delegation = send("#{method}_without_delegation")
        #if value_without_delegation.nil?
          #send(to).send(method)
        #else
          #value_without_delegation
        #end
      #end
      #alias_method_chain method, :delegation
    #end
  end

  def self.form_name(name)
    define_singleton_method :model_name do
      ActiveModel::Name.new(Object, nil, name.to_s.underscore)
    end
  end

  def self.attribute_names
    attribute_set.map(&:name)
  end

  protected

  def sanitize_args(args)
    args.each do |value|
      sanitize_for_mass_assignment(value)
    end
  end
end
