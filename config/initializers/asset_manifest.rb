# frozen_string_literal: true

class AssetManifest
  def self.manifest
    manifest_path = Rails.application.config.assets.manifest

    @manifest ||= if File.exist?(manifest_path)
                    JSON.parse(File.read(manifest_path))
                  else
                    {}
                  end
  end

  def self.assets
    AssetManifest.manifest
  end

  module Sprockets
    def assets
      AssetManifest.manifest
    end
  end
end

module Sprockets
  module Rails
    module Helper
      def compute_asset_path(path, _options = {})
        # Check if we are inside Sprockets context before calling check_dependencies!.
        check_dependencies!(path) if defined?(depend_on)

        digest_path = asset_digest_path(path) if digest_assets

        File.join(assets_prefix || "/", digest_path || path)
      end
    end
  end
end

class Sprockets::Manifest
  prepend AssetManifest::Sprockets
end
