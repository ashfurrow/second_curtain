require './lib/second_curtain/upload'
require 'uri'

describe Upload do
  it "should have instance variables set correctly upon initialization" do
    upload = Upload.new('expected', 'actual')
    expect(upload.expected_path).to eq('expected')
    expect(upload.actual_path).to eq('actual')
  end

  it "should return valid html from to_html" do
    upload = Upload.new('expected', 'actual')
    upload.uploaded_expected_url = URI("http://exmaple.com/1")
    upload.uploaded_actual_url = URI("http://exmaple.com/2")
    expect(upload.to_html).to eq("<li><a href='http://exmaple.com/1'>Expected</a>, <a href='http://exmaple.com/2'>Actual</li>")
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
    expect(expected_double).to receive(:public_url).and_return("http://exmaple.com/1.png")
    expect(actual_double).to receive(:write).with(anything)
    expect(actual_double).to receive(:public_url).and_return("http://exmaple.com/2.png")

    upload = Upload.new('/path/to/expected.png', '/path/to/actual.png')
    upload.upload(bucket, path)

    expect(upload.uploaded_expected_url).to eq("http://exmaple.com/1.png")
    expect(upload.uploaded_actual_url).to eq("http://exmaple.com/2.png")
  end
end
