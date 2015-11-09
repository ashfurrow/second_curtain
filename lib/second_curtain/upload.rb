require "s3"
require 'date'
require 'pathname'
require 'uri'

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
    expected_path = path + "/" + expected_filename
    expected_object = bucket.objects.build(expected_path)
    expected_object.content = open @expected_path
    @uploaded_expected_url = expected_object.url

    actual_filename = Pathname.new(@actual_path).basename.to_s
    actual_path = path + "/" + actual_filename

    actual_object = bucket.objects.build(actual_path)
    actual_object.content = open @actual_path
    @uploaded_actual_url = actual_object.url
  end
end
