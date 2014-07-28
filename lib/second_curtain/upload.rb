require 'aws-sdk'
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
    expected_object = bucket.objects[path + "/" + expected_filename]
    expected_object.write(:file => @expected_path)
    @uploaded_expected_url = expected_object.url_for(:read)

    actual_filename = Pathname.new(@actual_path).basename.to_s
    actual_object = bucket.objects[path + "/" + actual_filename]
    actual_object.write(:file => @actual_path)
    @uploaded_actual_url = actual_object.url_for(:read)
  end

  def to_html
    "<li><a href='#{ @uploaded_expected_url.to_s }'>Expected</a>, <a href='#{ @uploaded_actual_url.to_s }'>Actual</li>"
  end
end