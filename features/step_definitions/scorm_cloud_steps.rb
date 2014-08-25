##
## Generic
##
Then /^I will get a valid url$/ do
  expect(@last_url).to match(/http\:\/\/.+/)
end


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
  expect(@last_response).to eq(arg1)
end

Then /^the resonse should be the current time$/ do
  expect(@last_response).to match(/\d+/)
end

##
## Upload Service
##

When /^I upload a package$/ do
  token = @c.upload.get_upload_token
  expect(token).to_not be_nil
  path = File.join(File.dirname(__FILE__), '..', '..', 'spec', 'small_scorm_package.zip')
  @last_upload_path = @c.upload.upload_file(token, path)
  @last_uploaded_dir, @last_uploaded_file = @last_upload_path.split('/')
  expect(@last_uploaded_file).to include('.zip')
end

Then /^the package files should be available$/ do
  list = @c.upload.list_files.map { |f| f[:file] }
  expect(list).to include(@last_uploaded_file)
end

Then /^the package files should not be available$/ do
  list = @c.upload.list_files.map { |f| f[:file] }
  expect(list).to_not include(@last_uploaded_file)
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
  expect(@last_error).to_not be_nil
end



##
## Course Service
##

When /^I import a course$/ do
  expect(@last_uploaded_file).to_not be_nil
  @last_course_id = "small_scorm_course_#{rand(1000)}"
  hash = @c.course.import_course(@last_course_id, @last_uploaded_path)
  expect(hash).to_not be_nil
  expect(hash[:title]).to_not be_nil
end

Given /^a registered course$/ do
  step "I import a course"
end

Then /^the course should be in the course list$/ do
  expect(@c.course.get_course_list.find { |c| c.id == @last_course_id}).to_not be_nil
end

Then /^there should be (\d+) courses? in the list$/ do |count|
  expect(@c.course.get_course_list.size).to eq(count.to_i)
end

When /^I delete the course$/ do
  expect(@c.course.delete_course(@last_course_id)).to eq(true)
end

Then /^the course should not be in the course list$/ do
  expect(@c.course.get_course_list.find { |c| c.id == @last_course_id}).to be_nil
end

Then /^I can get a preview URL for the course$/ do
  expect(@c.course.preview(@last_course_id, "http://www.example.com")).to match(/http:\/\/.+/)
end

Then /^the course will have a properties url$/ do
  expect(@c.course.properties(@last_course_id)).to match(/http:\/\/.+/)
end

Then /^the course should exist$/ do
  expect(@c.course.exists(@last_course_id)).to be(true)
end

Then /^I can get the manifest for the course$/ do
  xml = @c.course.get_manifest(@last_course_id)
  doc = REXML::Document.new(xml)
  expect(doc.elements["//manifest"]).to_not be_nil
end

Then /^I can get the attributes for the course$/ do
  h = @c.course.get_attributes(@last_course_id)
  expect(h).to be_kind_of(Hash)
  expect(h[:showProgressBar]).to eq("false")
  expect(h[:showCourseStructure]).to eq("false")
end

When /^I update course attributes$/ do
  updated = @c.course.update_attributes(@last_course_id, 
    {:desiredHeight => "700", :commCommitFrequency => "59999" })
  expect(updated[:desiredHeight]).to eq("700")
  expect(updated[:commCommitFrequency]).to eq("59999")
end

Then /^the course attributes should be updated$/ do
  h = @c.course.get_attributes(@last_course_id)
  expect(h).to be_kind_of(Hash)
  expect(h[:desiredHeight]).to eq("700")
  expect(h[:commCommitFrequency]).to eq("59999")
end


##
## Registration
##

When /^I register a learner$/ do
  @last_reg_id = "small_scorm_course_#{rand(1000)}"
  r = @c.registration.create_registration(@last_course_id, @last_reg_id, 
      "fname", "lname", "lid", :email => "lid@example.com")
  expect(r).to be(true)
end

Then /^the learner should be in the registration list$/ do
  list = @c.registration.get_registration_list
  expect(list.find { |r| r.id == @last_reg_id }).to_not be_nil
end

Then /^the learner should not be in the registration list$/ do
  list = @c.registration.get_registration_list
  expect(list.find { |r| r.id == @last_reg_id }).to be_nil
end

When /^I delete the registration$/ do
  expect(@c.registration.delete_registration(@last_reg_id)).to be(true)
end

When /^I reset the registration$/ do
  expect(@c.registration.reset_registration(@last_reg_id)).to be(true)
end

When /^I launch the course$/ do
  @last_url = @c.registration.launch(@last_reg_id, "http://www.example.com/")
end

Then /^I can get the registration results$/ do
  @reg_results = @c.registration.get_registration_result(@last_reg_id, "full")
  expect(@reg_results).to include('<rsp stat="ok"><registrationreport')
end
