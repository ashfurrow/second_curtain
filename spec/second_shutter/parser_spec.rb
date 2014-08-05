require './lib/second_curtain/parser.rb'

describe Parser do
  before(:each) do
    @parser = Parser.new()
  end

  describe "when initialized" do
    it "has a nil latest_test_suite" do
      expect(@parser.latest_test_suite).to be_nil
    end

    it "has no failing commands" do
      expect(@parser.has_failing_commands).to be_falsey
      expect(@parser.failing_commands).to eq([])
    end

    it "returns valid failing commands" do
      command = double("command", :fails => true)
      test_case = double("test case", :commands => [command])
      test_suite = double("test suite", :test_cases => [test_case])

      @parser.instance_variable_set(:@test_suites, [test_suite])

      expect(@parser.failing_commands).to eq([command])
    end
  end

  it "correctly parses valid input" do
    data = File.read("./spec/sample_output.txt")
    data.split("\n").each do |line|
      @parser.parse_line(line)
    end

    expect(@parser.has_failing_commands).to be_truthy
    expect(@parser.failing_commands.count).to eq(1)
    expect(@parser.failing_commands.first.before_path).to eq("/Users/ash/Library/Application Support/iPhone Simulator/7.1/Applications/8C5F6EC1-9B2A-4418-A978-9733D338C27E/tmp/ASHViewControllerSpec/reference_a_view_controller_with_a_loaded_view_should_have_a_valid_snapshot@2x.png")
  end
end
