require 'spec_helper'

describe ScormCloud::Connection.new('a','b') do

	it { should respond_to(:call) }

end

