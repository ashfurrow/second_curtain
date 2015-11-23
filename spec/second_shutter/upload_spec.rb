require './lib/second_curtain/upload'
require 'uri'

describe Upload do
  it "should have instance variables set correctly upon initialization" do
    upload = Upload.new('expected', 'actual')
    expect(upload.expected_path).to eq('expected')
    expect(upload.actual_path).to eq('actual')
  end

  it "should upload properly" do
    path = "test/folder"
    expected_double = double()
    actual_double = double()
    bucket = double()

    doubles = {
      "test/folder/expected.png" => expected_double,
      "test/folder/actual.png" => actual_double
    }
    expect(bucket).to receive(:objects).twice.and_return(doubles)

    expect(expected_double).to receive(:write).with(anything)
    expect(actual_double).to receive(:write).with(anything)

    upload = Upload.new('/path/to/expected.png', '/path/to/actual.png')
    upload.upload(bucket, path)

    expect(upload.uploaded_expected_url).to eq("expected.png")
    expect(upload.uploaded_actual_url).to eq("actual.png")
  end
end
