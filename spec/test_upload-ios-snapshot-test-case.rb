require 'test/unit'
require 'upload-ios-snapshot-test-case'

class UploadTest < Test::Unit::TestCase
	def test_initializer
		upload = Upload.new('expected', 'actual')
		assert_equal 'expected', upload.expected_path
		assert_equal 'actual', upload.actual_path
	end

	
end
