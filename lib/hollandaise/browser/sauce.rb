module Hollandaise
  module Browser
    class Sauce < Base
      def initialize(browser, version, os, options)
        @browser, @version, @os, @options = browser, version, os, options
      end

      def selenium
        require 'sauce'
        require 'sauce/selenium'

        @selenium ||= ::Sauce::Selenium2.new(info)
      end

      def target
        dir.join(@os.to_s).join("#{@browser} #{@version}.png")
      end

      def info
        {
          :browser => @browser,
          :browser_version => @version,
          :os => @os,
          :browser_url => @url,
          :job_name => "#{@url}"
        }
      end
    end
  end
end

