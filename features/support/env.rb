require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require File.join(File.dirname(__FILE__), '/../../spec/apikey.rb')
require 'scorm_cloud'

require 'rspec/expectations'


##
## Cleanup before testing
##
Before do
  # Grab a connection
  unless @c
    @c = ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret)
  end

  # Cleanup all courses
  @c.course.get_course_list.each do |course|
    @c.course.delete_course(course.id)
  end
  expect(@c.course.get_course_list.count).to eq(0)

  unless @last_uploaded_file
    # Cleanup all zip packages
    @c.upload.list_files.each do |file|
      @c.upload.delete_files(file[:file])
    end
    raise "Cannot delete files" unless @c.upload.list_files.length == 0

    # Upload one we can use for testing
    token = @c.upload.get_upload_token
    path = File.join(File.dirname(__FILE__), '..', '..', 'spec', 'small_scorm_package.zip')
    @last_uploaded_path = @c.upload.upload_file(token, path)
    @last_uploaded_dir, @last_uploaded_file = @last_uploaded_path.split('/')
    expect(@last_uploaded_file).to include('.zip')

    sleep(5)
  end

  # was a course created?
  expect(@c.course.get_course_list.count).to eq(0)
  expect(@c.upload.list_files.count).to eq(1)

  @last_course_id = nil
  @last_error = nil
  @last_response = nil
end

After do
  # Cleanup all courses
  @c.course.get_course_list.each do |course|
    @c.course.delete_course(course.id)
  end
end
