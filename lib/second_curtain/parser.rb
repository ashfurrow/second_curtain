require 'second_curtain/xcode_test_case'
require 'second_curtain/test_suite'
require 'second_curtain/kaleidoscope_command'

# Lifted from https://github.com/orta/Snapshots/blob/master/SnapshotDiffs/ORLogReader.m

class Parser
  def initialize
    @test_suites = []
  end

  def parse_line(line)
    if line.include?("Test Suite")
      test_suite = TestSuite.suite_from_line(line)
      @test_suites.push test_suite unless test_suite == nil
    end

    if line.include?("Test Case") && latest_test_suite
      if line.include?("started.")
        test_case = TestCase.test_case_from_line(line)
        latest_test_suite.test_cases.push test_case unless test_case == nil
      elsif line.include?("' failed (")
        latest_test_suite.latest_test_case.latest_command.fails = true
      end
    end

    if line.include?("ksdiff") && latest_test_suite
      command_string = extract_command_string_from_line(line)
      command = KaleidoscopeCommand.command_from_line(command_string)
      if command != nil
        latest_test_suite.latest_test_case.add_command command
      end
    end
  end

  def latest_test_suite
    @test_suites.last
  end

  def extract_command_string_from_line(line)
    return line.split("diff:\n").last
  end

  def failing_commands
    @test_suites.map { |e| e.test_cases }.flatten.map { |e| e.commands }.flatten.select { |e| e.fails }
  end

  def has_failing_commands
    failing_commands.count > 0
  end
end
