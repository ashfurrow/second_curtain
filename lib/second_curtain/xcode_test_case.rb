class TestCase
  attr_accessor :commands

  def self.test_case_from_line(line)
    components = line.split("Test Case '-[")
    end_components = line.split("]' started.")

    if components.count == 2 && end_components.count == 2
      # Let's make it readable
      name = components.last.split("'").first
      name = name.split(" ").last
      name = name.split("]").first
      name = name.gsub("_", " ")

      # We avoid hitting ends of words by addng the space, but that potentially misses the first one
      name += " "

      name.gsub!(" hasnt ", " hasn't")
      name.gsub!(" isn t", " isn't")
      name.gsub!(" won t", " won't")
      name.gsub!(" don t", " don't")
      name.gsub!(" doesn t", " doesn't")
      name.gsub!(" shouldn t", " shouldn't")
      name.gsub!(" can t", " can't")

      first_char_upper = name[1].upcase
      name[0..1] = first_char_upper
      TestCase.new(name)
    end
  end

  def initialize (name)
    @commands = []
  end

  def add_command(command)
    @commands.push(command)
  end

  def latest_command
    @commands.last
  end
end

