module Hollandaise
  module Browser
    class Base
      attr_reader :browser

      def run_and_take_screenshot(url)
        @url = url

        selenium.navigate.to url
        sleep @options[:delay].to_i
        selenium.execute_script %{window.resizeTo(1280, 1024)}
        take_screenshot
      end

      def take_screenshot
        target.parent.mkpath

        selenium.save_screenshot(target.to_s)
      end

      def close
        selenium.quit

        @selenium = nil
      end

      def dir
        Hollandaise.dir
      end
    end
  end
end

