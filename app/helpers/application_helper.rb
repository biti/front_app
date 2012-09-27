module ApplicationHelper
  def resource_path path
    File.join(Fair::Application.config.resources_dir, path)
  end

  def resource_url path
    (Fair::Application.config.resources_abs ? '' : root_url) +
      Fair::Application.config.resources_url + '/' + path.to_s
  end
end
