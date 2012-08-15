require 'hollandaise/browser/base'
require 'hollandaise/browser/sauce'
require 'hollandaise/browser/selenium'

module Hollandaise
  module Browser
    def self.for(browser, options)
      browser = browser.dup

      case browser.shift
      when :sauce
        Hollandaise::Browser::Sauce.new(*browser, options)
      when :selenium
        Hollandaise::Browser::Selenium.new(*browser, options)
      end
    end
  end
end

