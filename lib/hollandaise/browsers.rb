module Hollandaise
  class Browsers
    def self.for(browsers, options = {})
      new(browsers.flatten.collect { |browser| Hollandaise::Browser.for(self.send(browser), options) })
    end

    def self.ie7
      [ :sauce, 'iexplore', '7', 'Windows 2003' ]
    end

    def self.ie8
      [ :sauce, 'iexplore', '8', 'Windows 2003' ]
    end

    def self.ie9
      [ :sauce, 'iexplore', '9', 'Windows 2008' ]
    end

    def self.ffwin10
      [ :sauce, 'firefox', '10', 'Windows 2008' ]
    end

    def self.chromewin
      [ :sauce, 'chrome', '', 'Windows 2008' ]
    end

    def self.firefox
      [ :selenium, :firefox ]
    end

    def self.chrome
      [ :selenium, :chrome ]
    end

    def initialize(browsers)
      @browsers = browsers
    end

    def each(&block)
      @browsers.each(&block)
    end

    def run
      @browsers.each do |browser|
        begin
          yield browser
        ensure
          browser.close
        end
      end
    end
  end
end
