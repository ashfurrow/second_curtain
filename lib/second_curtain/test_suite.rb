class TestSuite
  attr_accessor :test_cases
  attr_accessor :name

  def self.suite_from_line(line)
    components = line.split("Test Suite '")
    end_components = line.split("' started at")

    if components.count == 2 && end_components.count == 2
      TestSuite.new(components.last.split("'").first)
    end
  end

  def initialize (name)
    @name = name
    @test_cases = []
  end

  def latest_test_case
    @test_cases.last
  end
end
