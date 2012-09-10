module Hollandaise
  module Browser
    class Base
      attr_reader :browser

      def run(url)
        @url = url

        selenium.navigate.to url
        sleep @options[:delay].to_i
        selenium.execute_script %{window.resizeTo(1280, 1024)}
      end

      def dir
        @options[:dir]
      end

      def take_screenshot
        target.parent.mkpath

        selenium.save_screenshot(target.to_s)
      end

      def close
        selenium.quit

        @selenium = nil
      end
    end
  end
end

