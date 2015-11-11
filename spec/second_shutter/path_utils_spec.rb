require './lib/second_curtain/path_utils.rb'

describe PathUtils do
  before(:each) do
  end

  describe "composing a path" do
    it "yields a concatenation of these components without leading and trailing slashes" do
      expect(PathUtils.pathWithComponents(["component1", "component2"])).to eq("component1/component2")
    end

    it "yields a concatenation of these components without leading and trailing slashes" do
      expect(PathUtils.pathWithComponents(["/component1/component1b/", "/component2/"])).to eq("component1/component1b/component2")
    end

    it "yields an empty string when called without components" do
      expect(PathUtils.pathWithComponents([])).to eq("")
    end

    it "yields a string without leading slash when called with an empty first component" do
      expect(PathUtils.pathWithComponents(["", "/component2"])).to eq("component2")
    end

    it "yields a string without trailing slash when called with an empty last component" do
      expect(PathUtils.pathWithComponents(["component1", ""])).to eq("component1")
    end

    it "yields an empty string when called with a single slash" do
      expect(PathUtils.pathWithComponents(["/"])).to eq("")
    end
  end
end
