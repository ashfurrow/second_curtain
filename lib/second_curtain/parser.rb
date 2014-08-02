require 'second_curtain/xcode_test_case'
require 'second_curtain/test_suite'
require 'second_curtain/kaleidoscope_command'

# Lifted from https://github.com/orta/Snapshots/blob/master/SnapshotDiffs/ORLogReader.m

class Parser
  def initialize
    @test_suites = []
    @logs = []
    @diff_commands = []
  end

  def parse_line(line)
    @logs.push(line)

    if line.include?("Test Suite")
      test_suite = TestSuite.suite_from_line(line)
      @test_suites.push test_suite unless test_suite == nil
    end

    if line.include?("Test Case") && latest_test_suite
      test_case = TestCase.test_case_from_line(line)
      latest_test_suite.test_cases.push test_case unless test_case == nil
    end

    if line.include?("ksdiff") && latest_test_suite
      command_string = extract_command_string_from_line(line)
      command = KaleidoscopeCommand.command_from_line(command_string)
      if command != nil
        latest_test_suite.latest_test_case.add_command command
        @diff_commands.push(command)
      end
    end
  end

  def latest_test_suite
    @test_suites.last
  end

  def extract_command_string_from_line(line)
    return line.split("diff:\n").last
  end

  def has_snapshot_errors
    return unique_diff_commands
  end

  def unique_diff_commands

  end
end
