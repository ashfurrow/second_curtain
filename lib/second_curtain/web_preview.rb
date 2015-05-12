require 'mustache'

class WebPreview
  attr_reader :uploads

  def initialize(uploads)
    @uploads = uploads
  end

  def generate_html
    lib_path = File.expand_path(File.dirname(__FILE__))
    template = File.read(lib_path + "/template.mustache.html")
    
    Mustache.render(template, :uploads => @uploads, :travis_id =>  ENV['TRAVIS_JOB_ID'], :circle_ci_id => ENV['CIRCLE_BUILD_NUM'])
  end
end
