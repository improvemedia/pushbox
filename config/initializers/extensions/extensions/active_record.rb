module ActiveRecord::Calculations
  def pluck_hash *keys
    pluck(*keys).map{ |pa| Hash[*keys.zip(pa).flatten]}
  end
end

# According to https://github.com/rails/rails/issues/10643
# There are no fix. So, let's make some monkeypatches.
# I hope this is safe enough.
class ActiveRecord::Associations::Builder::BelongsTo
  def valid_options
    super + [:foreign_type, :polymorphic, :unscoped, :touch, :counter_cache]
  end
end

module ActiveRecord::Associations
  class BelongsToUnscopedPolymorphicAssociation < BelongsToPolymorphicAssociation
    def target_scope
      all = klass.unscoped
      scope = ActiveRecord::AssociationRelation.new(klass, klass.arel_table, self)
      scope.merge! all
      scope.default_scoped = all.default_scoped?
      scope
    end
  end
end

class ActiveRecord::Reflection::AssociationReflection
  def association_class
    case macro
    when :belongs_to
      if options[:polymorphic]
        if options[:unscoped]
          ActiveRecord::Associations::BelongsToUnscopedPolymorphicAssociation
        else
          ActiveRecord::Associations::BelongsToPolymorphicAssociation
        end
      else
        ActiveRecord::Associations::BelongsToAssociation
      end
    when :has_and_belongs_to_many
      ActiveRecord::Associations::HasAndBelongsToManyAssociation
    when :has_many
      if options[:through]
        ActiveRecord::Associations::HasManyThroughAssociation
      else
        ActiveRecord::Associations::HasManyAssociation
      end
    when :has_one
      if options[:through]
        ActiveRecord::Associations::HasOneThroughAssociation
      else
        ActiveRecord::Associations::HasOneAssociation
      end
    end
  end
end
