require './lib/second_curtain/kaleidoscope_command'

describe KaleidoscopeCommand do
	it "should return a valid command from a valid line" do
		line = 'ksdiff "/first/path.png" "/second/path.png"'
		command = KaleidoscopeCommand.command_from_line line
		expect(command).not_to be_nil
		expect(command.before_path).to eq("/first/path.png")
		expect(command.after_path).to eq("/second/path.png")
		expect(command.fails).to be_falsey
	end

	it "should return nil from an invalid line" do
		line = 'this shouldn\'t work'
		command = KaleidoscopeCommand.command_from_line line
		expect(command).to be_nil
	end

	it "should initialize correctly" do
		command = KaleidoscopeCommand.new('before', 'after')
		expect(command.before_path).to eq("before")
		expect(command.after_path).to eq("after")
		expect(command.fails).to be_falsey
	end
end
