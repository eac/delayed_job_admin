namespace :delayed_job_admin do
  desc "Copy public files to main application."
  task :copy_assets do   
    plugin_root     = File.expand_path(File.join(File.dirname(__FILE__), '..'))
    stylesheet_path = 'public/stylesheets/delayed_job_admin.css'
    javascript_path = 'public/javascripts/delayed_job_admin.js'
    assets = { 
      File.join(plugin_root, stylesheet_path) => File.join(Rails.root, stylesheet_path),
      File.join(plugin_root, javascript_path) => File.join(Rails.root, javascript_path)
    }

    assets.each do |asset_plugin_path, asset_public_path|
      puts "Copying #{asset_plugin_path} to #{asset_public_path}"
      FileUtils.copy_entry(asset_plugin_path, asset_public_path, false, false, true) 
    end

  end
end