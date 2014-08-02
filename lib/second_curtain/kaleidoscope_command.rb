class KaleidoscopeCommand
  def self.command_from_line(line)
    components = line.split("\"")
    if components.count > 4
      KaleidoscopeCommand.new(line, components[1], components[3])
    end
  end

  def initialize(full_command, before_path, after_path)
    @full_command = full_command
    @before_path = before_path
    @after_path = after_path
  end
end

