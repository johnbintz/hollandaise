require 'arbre'
require 'pathname'

module Hollandaise
  class CLI < Thor
    include Thor::Actions
    source_root File.expand_path('../../../skel', __FILE__)

    desc "cook", "Use the config file and take all the screenshots listed in there"
    def cook
      Hollandaise.projects.each(&:run)
    end

    desc "project NAME", "Create a skeletal project file"
    def project(name)
      @name = name

      template 'hollandaise.rb.tt', 'hollandaise.rb'
    end

    desc "sauce URL BROWSER BROWSER...", "Take screenshots of a URL on Sauce Labs"
    method_options :delay => 0
    def sauce(*browsers)
      if browsers.first && browsers.first[%r{^http}]
        url = browsers.shift
      else
        url = Hollandaise.url
      end

      if Hollandaise.browsers && browsers.empty?
        browsers = Hollandaise.browsers
      end

      browser_objects = Hollandaise::Browsers.for(browsers, options)

      browser_objects.run do |browser|
        browser.run_and_take_screenshot(url)
      end

      html = Arbre::Context.new do
        html do
          head do
            title "Sauce Labs screenshots for #{url}" 
          end

          body do
            table do
              thead do
                tr do
                  browser_objects.each do |browser|
                    th browser.browser
                  end
                end
              end

              tbody do
                browser_objects.each do |browser|
                  td(:valign => :top) do
                    img(:src => browser.target)
                  end
                end
              end
            end
          end
        end
      end

      File.open('index.html', 'wb') { |fh| fh.print html.to_s }
    end

    default_task :sauce
  end
end
