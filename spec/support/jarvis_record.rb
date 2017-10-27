# override JarvisRecord to make it writable in tests
class JarvisRecord < ActiveRecord::Base
  self.abstract_class = true
end
