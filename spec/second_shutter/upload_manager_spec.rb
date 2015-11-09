require './lib/second_curtain/upload_manager'
require './lib/second_curtain/upload'

describe UploadManager do
  it "should have instance variables set correctly upon initialization" do
    bucket = double()
    path_prefix = "test/"
    upload_manager = UploadManager.new(bucket, path_prefix)

    expect(upload_manager.instance_variable_get(:@uploads)).to eq([])
    expect(upload_manager.instance_variable_get(:@path_prefix)).to eq(path_prefix)
    expect(upload_manager.instance_variable_get(:@bucket)).to eq(bucket)
  end

  it "propertly enqueues new uploads" do
    bucket = double()
    path_prefix = "test/"
    upload_manager = UploadManager.new(bucket, path_prefix)
    uploads = upload_manager.instance_variable_get(:@uploads)
    expect(uploads.count).to eq(0)

    upload_manager.enqueue_upload('expected', 'actual')
    uploads = upload_manager.instance_variable_get(:@uploads)
    expect(uploads.count).to eq(1)

    upload = uploads[0]
    expect(upload.expected_path).to eq('expected')
    expect(upload.actual_path).to eq('actual')
  end

  it "returns nil when uploading nothing" do
    bucket = double()
    path_prefix = "test/"
    upload_manager = UploadManager.new(bucket, path_prefix)

    expect(upload_manager.upload("test/")).to eq(nil)
  end

  it "properly uploads" do
    double = double()
    expect(double).to receive(:write)
    expect(double).to receive(:public_url).and_return("http://example.com")

    bucket = double()
    expect(bucket).to receive(:objects).and_return([])

    path_prefix = "test/"
    upload_manager = UploadManager.new(bucket, path_prefix)

    upload = double()
    expect(upload).to receive(:upload)

    upload_manager.instance_variable_set(:@uploads, [upload])

    result = upload_manager.upload("folder")
    expect(result).to eq("http://example.com")
  end
end
