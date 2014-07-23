require 'aws-sdk'
require 'date'
require 'pathname'

class Upload
	attr_reader :expected_path
	attr_reader :actual_path
	attr_accessor :uploaded_expected_url
	attr_accessor :uploaded_actual_url

	def initialize(expected_path, actual_path)
		@expected_path = expected_path
		@actual_path = actual_path
	end

	def self.upload(bucket_name, path_prefix, uploads)
		s3 = AWS::S3.new
		bucket = s3.buckets[bucket_name]
		now = DateTime.now()
		folder_name = now.strftime('%Y-%m-%d--%H-%M')
		title_time = now.strftime('%Y-%m-%d--%H-%M')

		if bucket == nil
			abort "error: bucket does not yet exist on S3: #{bucket_name}"
		end

		s = "<html><head><title>Tests on #{ title_time }</title></head><body><ul>"

		uploads.each do |upload|
			expected_filename = Pathname.new(upload.expected_path).basename.to_s
			expected_object = bucket.objects[path_prefix + folder_name + "/" + expected_filename]
			expected_object.write(:file => upload.expected_path)
			upload.uploaded_expected_url = expected_object.url_for(:read)

			actual_filename = Pathname.new(upload.actual_path).basename.to_s
			actual_object = bucket.objects[path_prefix + folder_name + "/" + actual_filename]
			actual_object.write(:file => upload.actual_path)
			upload.uploaded_actual_url = actual_object.url_for(:read)

			s += "<li><a href='#{ upload.uploaded_expected_url.to_s }'>Expected</a>, "
			s += "<a href='#{ upload.uploaded_actual_url.to_s }'>Actual</li>"
		end

		s += "</ul></body></html>"

		index_object = bucket.objects[path_prefix + folder_name + "/index.html"]
		index_object.write(s)
		index_object.url_for(:read).to_s
	end

	def to_s
		"There was a difference between images: #{expectedPath} and #{actualPath}."
	end
end