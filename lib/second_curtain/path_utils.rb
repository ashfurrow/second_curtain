class PathUtils

  # Returns a path  composed of components, without leading and trailing slashes
  def self.pathWithComponents(components)
    path = ""

    for component in components do
      path = self.sanitizePathComponent(path + "/" + self.sanitizePathComponent(component))
    end

    return path
  end

  :private

  # Takes a path component and strips leading and trailing slashes
  def self.sanitizePathComponent(component)
    # Remove leading and trailing slash
    component.gsub(/^\//, "").chomp("/")
  end
end
