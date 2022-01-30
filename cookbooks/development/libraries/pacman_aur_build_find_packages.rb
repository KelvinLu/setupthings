# frozen_string_literal: true

class Chef
  class Resource
    def find_built_packages(package_name, build_dir: "#{Chef::Config[:file_cache_path]}/builds/")
      ::Dir.glob(::File.join(build_dir, "#{package_name}/#{package_name}-*.pkg.tar.*")).map do |path|
        file        = ::File.basename(path)
        extension   = ::File.extname(file)
        version, _  = file[(package_name.length)..-1].split('.pkg.tar.', 2)

        { path: path, version: version, extension: extension }
      end
    end
  end
end
