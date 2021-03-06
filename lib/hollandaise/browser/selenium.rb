module Hollandaise
  module Browser
    class Selenium < Base
      def initialize(browser, options)
        @browser, @options = browser, options
      end

      def selenium
        require 'selenium/webdriver'

        @selenium ||= ::Selenium::WebDriver.for(@browser)
      end

      def name
        @browser
      end

      def target
        dir.join("#{@browser}.png")
      end
    end
  end
end

