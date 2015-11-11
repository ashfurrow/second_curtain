require 'aws-sdk-v1'
require 'date'
require 'pathname'
require 'uri'
require 'second_curtain/path_utils'

class Upload
  attr_reader :expected_path
  attr_reader :actual_path
  attr_accessor :uploaded_expected_url
  attr_accessor :uploaded_actual_url

  def initialize(expected_path, actual_path)
    @expected_path = expected_path
    @actual_path = actual_path
  end

  def upload(bucket, path)
    abort unless bucket
    abort unless path

    expected_filename = Pathname.new(@expected_path).basename.to_s
    expected_object = bucket.objects[PathUtils.pathWithComponents([path, expected_filename])]
    expected_object.write(:file => @expected_path)
    @uploaded_expected_url = expected_object.public_url

    actual_filename = Pathname.new(@actual_path).basename.to_s
    actual_object = bucket.objects[PathUtils.pathWithComponents([path, actual_filename])]
    actual_object.write(:file => @actual_path)
    @uploaded_actual_url = actual_object.public_url
  end
end
