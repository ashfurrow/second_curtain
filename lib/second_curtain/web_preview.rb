require 'mustache'

class WebPreview
  attr_reader :uploads

  def initialize(uploads)
    @uploads = uploads
  end

  def generate_html
    template = File.read("template.mustache.html")
    Mustache.render(template, :uploads => @uploads)
  end
end
