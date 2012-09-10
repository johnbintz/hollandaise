require 'arbre'
require 'pathname'

module Hollandaise
  class CLI < Thor
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

      browser_objects = Hollandaise::Browsers.for(browsers, options.merge(:dir => dir))

      browser_objects.each do |browser|
        begin
          browser.run(url)
          browser.take_screenshot
        ensure
          browser.close
        end
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

    no_tasks do
      def dir
        Pathname("screenshots")
      end
    end
  end
end
