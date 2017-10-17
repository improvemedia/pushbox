# frozen_string_literal: true

class User < JarvisRecord
  default_scope -> { where(type: "User") }
end
