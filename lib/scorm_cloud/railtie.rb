require 'rails'
require 'scorm_cloud/scorm_rails_helpers'

class ScormCloud::Railtie < Rails::Railtie

	config.scorm_cloud = ActiveSupport::OrderedOptions.new

  initializer "scorm_cloud.scorm_rails_helpers" do
    ActionController::Base.send :include, ScormCloud::ScormRailsHelpers
  end

end

