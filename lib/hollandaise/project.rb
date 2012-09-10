require 'uri'

module Hollandaise
  class Project
    def initialize(project_name)
      @project_name = project_name
    end

    def root(root)
      @root = URI(root)
    end

    def screenshot(name, uri)
      @screenshots ||= []

      @screenshots << [ name, uri ]
    end

    def browsers(*browsers)
      @browsers = browsers
    end

    def run
      urls.each do |url, name|
        Hollandaise.chdir "#{@project_name}/#{name}" do
          browser_objects.run do |browser|
            browser.run_and_take_screenshot(url)
          end
        end
      end
    end

    private
    def urls
      @screenshots.collect do |name, uri|
        [ @root.merge(URI(uri)), name ]
      end
    end

    def browser_objects
      @browser_objects ||= Hollandaise::Browsers.for(@browsers)
    end
  end
end

