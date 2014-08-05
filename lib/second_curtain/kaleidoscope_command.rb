class KaleidoscopeCommand
  attr_accessor :fails
  attr_accessor :before_path
  attr_accessor :after_path
  
  def self.command_from_line(line)
    components = line.split("\"")
    if components.count >= 4
      KaleidoscopeCommand.new(components[1], components[3])
    end
  end

  def initialize(before_path, after_path)
    @before_path = before_path
    @after_path = after_path
  end
end

