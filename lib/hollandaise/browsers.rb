module Hollandaise
  module Browsers
    def self.for(browsers, options)
      browsers.collect { |browser| Hollandaise::Browser.for(self.send(browser), options) }
    end

    def self.each(browsers, options, &block)
      self.for(browsers, options).each(&block)
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
  end
end
