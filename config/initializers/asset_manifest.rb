class AssetManifest
  def self.manifest
    manifest_path = Rails.application.config.assets.manifest

    if File.exists?(manifest_path)
      @manifest ||= JSON.parse(File.read(manifest_path))
    else
      @manifest ||= {}
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
      def compute_asset_path(path, options = {})
        # Check if we are inside Sprockets context before calling check_dependencies!.
        check_dependencies!(path) if defined?(depend_on)

        if digest_path = asset_digest_path(path)
          path = digest_path if digest_assets
        end

        File.join(assets_prefix || "/", path)
      end
    end
  end
end

class Sprockets::Manifest
  prepend AssetManifest::Sprockets
end

