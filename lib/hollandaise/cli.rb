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

      Hollandaise::Browsers.each(browsers, options) do |browser|
        begin
          browser.run(url)
          browser.take_screenshot(dir)
        ensure
          browser.close
        end
      end

      if false

      html = Builder::XmlMarkup.new
      html.html {
        html.head {
          html.title { "Sauce Labs screenshots for #{url}" }
        }

        html.body {
          html.table {
            html.tr {
              browsers.each { |browser| html.th(browser) }
            }

            html.tr {
              Hollandaise::Browsers.for(browsers).each { |browser|
                html.td(:valign => 'top') {
                  html.img(:src => screenshot_target_for(browser))
                }
              }
            }
          }
        }
      }

      File.open('index.html', 'wb') { |fh| fh.print html.to_s }

      end
    end

    default_task :sauce

    no_tasks do
      def dir
        Pathname("screenshots")
      end
    end
  end
end
