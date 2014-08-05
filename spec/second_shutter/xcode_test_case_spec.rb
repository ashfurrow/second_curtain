require './lib/second_curtain/xcode_test_case'

describe XcodeTestCase do
  it "should generate a valid test case from a valid line" do
    line = "Test Case '-[ARAnimatedTickViewSpec initWithSelection_inits_with_selected]' started."
    test_case = XcodeTestCase.test_case_from_line(line)
    expect(test_case).not_to be_nil
    expect(test_case.name).to eq("InitWithSelection inits with selected")
  end

  it "should return nil from an invalid line" do
    line = "Something that should't work"
    test_case = XcodeTestCase.test_case_from_line(line)
    expect(test_case).to be_nil
  end

  it "should initialize properly" do
    name = "Some test"
    test_case = XcodeTestCase.new(name)
    expect(test_case.name).to eq(name)
  end
end