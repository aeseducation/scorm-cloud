require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require File.join(File.dirname(__FILE__), 'apikey.rb')
require 'scorm_cloud'

require 'rspec/expectations'

Before do
	
	# Cleanup all zip packages
	temp = ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret)
	temp.upload.list_files.each do |file|
		puts temp.upload.delete_files(file[:file])
	end
	raise "Cannot delete files" unless temp.upload.list_files.length == 0

	# Upload one we can use for testing
	token = temp.upload.get_upload_token
	path = File.join(File.dirname(__FILE__), '..', '..', 'spec', 'small_scorm_package.zip')
	temp.upload.upload_file(token, path)

end


After do
	# Cleanup -- Use the array style
	temp = ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret)
	temp.upload.delete_files(temp.upload.list_files.map { |file| file[:file] })
	raise "Cannot delete files" unless temp.upload.list_files.length != 0
end