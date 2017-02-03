# Rustici SCORM Cloud Ruby Client

> Let me know if you are interested in taking it over. I developed the code but never
> actually used it in production. Use with caution.

This ruby gem is provides a ruby interface to the Rustici Scorm Cloud.


## Shell CLI Interface

$ `gem install scorm_cloud`  
$ `scorm_cloud rustici.course.getCourseList -—appid myappid -—secret mysecret`
$ `scorm_cloud rustici.course.getMetadata --courseid a-valid-course-id-12345`


## Standard Ruby Use

    require 'scorm_cloud'
    sc = ScormCloud::ScormCloud.new("my_app_id", "my_secret_key")
    # sc = ScormCloud::ScormCloud.new("my_app_id", "my_secret_key", "http://custom/api/url")
    # sc = ScormCloud::ScormCloud.new("my_app_id", "my_secret_key", "http://custom/api/url", custom_logger)
    sc.course.get_course_list.each { |c| puts "#{c.id} #{c.title}"}


## Ruby on Rails Use

*Place the following in: Gemfile*

    require 'scorm_cloud', :git => 'git@github.com:aeseducation/scorm-cloud.git'

*Place the following in: config/initializers/scorm_cloud.rb*

    MyApplication::Application.configure do |config|
      config.scorm_cloud.appid = "my_app_id"
      config.scorm_cloud.secretkey = "my_secret_key"
      # config.scorm_cloud.api_url = "http://custom/api/url"
    end

*Place the following in: app/controllers.course_controller.rb*

    class CourseController < ApplicationController
      def index
        @courses = scorm_cloud.course.get_course_list
      end
      
      def launch
        return_url = course_index_url
        reg = scorm_cloud.registrations.create_registration(...)
        redirect_to scorm_cloud.registrations.launch(...)
      end
    end

*Place the following in: app/views/course/index.html.erb*

    <ul>
      <%= @courses.each |course| %>
        <li>
          <%= link_to course_launch_path(course.title, course.id) %>
        </li>
      <% end %>
    </ul>
