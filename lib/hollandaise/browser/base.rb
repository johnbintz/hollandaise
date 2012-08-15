module Hollandaise
  module Browser
    class Base
      def run(url)
        @url = url

        selenium.navigate.to url
        sleep @options[:delay].to_i
        selenium.execute_script %{window.resizeTo(1280, 1024)}
      end

      def take_screenshot(target_dir)
        target = target_for(target_dir)
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

