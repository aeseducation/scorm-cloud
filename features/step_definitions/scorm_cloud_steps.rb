##
## Debug Service
##

When /^I ping the server$/ do
	@last_response = @c.debug.ping
end

When /^I authping the server$/ do
	@last_response = @c.debug.auth_ping
end

When /^I get the current time$/ do
	@last_response = @c.debug.get_time
end

Then /^the response should be "([^"]*)"$/ do |arg1| #"
  @last_response.should eq(arg1)
end

Then /^the resonse should be the current time$/ do
	@last_response.should match(/\d+/)
end

##
## Upload Service
##

When /^I upload a package$/ do
	token = @c.upload.get_upload_token
	token.should_not be_nil
	path = File.join(File.dirname(__FILE__), '..', '..', 'spec', 'small_scorm_package.zip')
	@last_upload_path = @c.upload.upload_file(token, path)
	@last_uploaded_dir, @last_uploaded_file = @last_upload_path.split('/')
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

When /^I delete a non\-existant package$/ do
	@last_error = nil
	begin
		@c.upload.delete_files("thiscoursedoesnotexist")
	rescue => e
		puts e.inspect
		@last_error = e
	end
end

Then /^I should get an error$/ do
  @last_error.should_not be_nil
end



##
## Course Service
##

When /^I import a course$/ do
	@last_uploaded_file.should_not be_nil
	@last_course_id = "small_scorm_course_#{rand(1000)}"
	hash = @c.course.import_course(@last_course_id, @last_uploaded_path)
	hash.should_not be_nil
	hash[:title].should_not be_nil
end

Then /^the course should be in the course list$/ do
	@c.course.get_course_list.find { |c| c.id == @last_course_id}.should_not be_nil
end

Then /^there should be (\d+) courses? in the list$/ do |count|
	@c.course.get_course_list.size.should eq(count.to_i)
end

When /^I delete the course$/ do
	@c.course.delete_course(@last_course_id).should eq(true)
end

Then /^the course should not be in the course list$/ do
	@c.course.get_course_list.find { |c| c.id == @last_course_id}.should be_nil
end

Then /^I can get a preview URL for the course$/ do
	@c.course.preview(@last_course_id).should match(/http:\/\/.+/)
end

Then /^the course will have a properties url$/ do
	@c.course.properties(@last_course_id).should match(/http:\/\/.+/)
end
