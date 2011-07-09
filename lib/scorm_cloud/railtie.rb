require 'scorm_cloud/scorm_rails_helpers'
module ScormCloud
  class Railtie < Rails::Railtie
    initializer "scorm_cloud.scorm_rails_helpers" do
      ActionController::Base.send :include, ScormRailsHelpers
    end
  end
end

