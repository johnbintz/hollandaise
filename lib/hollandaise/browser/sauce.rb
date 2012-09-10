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

      def run_and_take_screenshot(url, *args)
        self.class.start_tunnel if URI(url).host == 'localhost'

        super
      end

      def self.start_tunnel
        return @tunnel if @tunnel

        @tunnel = ::Sauce::Connect.new
        @tunnel.connect
        @tunnel.wait_until_ready

        at_exit do
          @tunnel.disconnect
        end
      end

      def target
        dir.join(@os.to_s).join("#{@browser} #{@version || 'latest'}.png")
      end

      def name
        "#{@browser} #{@version} #{@os}"
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

