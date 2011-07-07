
Given /^connection to the scorm cloud$/ do
  @c = ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret)
end

##
## Upload Service
##

When /^I upload a package$/ do
	token = @c.upload.get_upload_token
	token.should_not be_nil
	path = File.join(File.dirname(__FILE__), '..', '..', 'spec', 'small_scorm_package.zip')
	@last_uploaded_dir, @last_uploaded_file = @c.upload.upload_file(token, path).split('/')
	@last_uploaded_file.should include('.zip')
end

Then /^the package files should be available$/ do
	list = @c.upload.list_files.map { |f| f[:file] }
	list.should include(@last_uploaded_file)
end

Then /^the package files should not be available$/ do
	list = @c.upload.list_files.map { |f| f[:file] }
	list.should_not include(@last_uploaded_file)
end

When /^I delete the package$/ do
	@c.upload.delete_files(@last_uploaded_file)
end

