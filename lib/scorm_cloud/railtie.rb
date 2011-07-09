require 'scorm_cloud/scorm_rails_helpers'
module ScormCloud
  class Railtie < Rails::Railtie
    initializer "scorm_cloud.view_helpers" do
      ActionView::Base.send :include, ScormRailsHelpers
    end
  end
end

