require './lib/second_curtain/test_suite'

describe TestSuite do 
  it "should create a valid test suite from a valid line" do
    line = "Test Suite 'ARAnimatedTickViewSpec' started at 2014-08-02 12:10:48 +0000."
    test_suite = TestSuite.suite_from_line(line)
    expect(test_suite).not_to be_nil
    expect(test_suite.name).to eq("ARAnimatedTickViewSpec")
  end 

  it "should generate a valid test case from a valid line" do
    line = "Something that shouldn't work"
    test_suite = TestSuite.suite_from_line(line)
    expect(test_suite).to be_nil
  end

  it "should be initialized correctly" do
    name = "Some Suite"
    test_suite = TestSuite.new(name)
    expect(test_suite.name).to eq(name)
    expect(test_suite.test_cases).not_to be_nil
  end

  it "correctly returns the final test case" do
    test_suite = TestSuite.new("Some Suite")

    test_case = double()
    test_suite.test_cases = [test_case]

    expect(test_suite.latest_test_case).to eq(test_case)
  end
end
