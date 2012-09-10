module Hollandaise
  module Browser
    class Base
      attr_reader :browser

      def run_and_take_screenshot(url, screen_size = [ 1280, 1024 ])
        @url = url

        selenium.navigate.to url
        sleep @options[:delay].to_i
        selenium.manage.window.resize_to(*screen_size)
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

