require 'aws-sdk-v1'
require 'second_curtain/upload'
require 'second_curtain/web_preview'
require 'second_curtain/path_utils'

class UploadManager
  def initialize (bucket, path_prefix)
    abort "error: Second Curtain must supply an S3 bucket" unless bucket
    abort "error: Second Curtain must supply a path prefix of at least '/'" unless path_prefix

    @uploads = []
    @path_prefix = path_prefix
    @bucket = bucket
  end

  def enqueue_upload(expected_path, actual_path)
    @uploads.push(Upload.new(expected_path, actual_path))
  end

  def upload(folder_name)
    return nil unless @uploads.count > 0

    @uploads.each do |upload|
      upload.upload(@bucket, @path_prefix)
    end

    preview = WebPreview.new(@uploads)
    index_object = @bucket.objects[PathUtils.pathWithComponents([@path_prefix, folder_name, "index.html"])]
    index_object.write(preview.generate_html)
    index_object.public_url.to_s
  end
end
