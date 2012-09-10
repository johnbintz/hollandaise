require 'uri'
require 'rainbow'
require 'rack/proxy'
require 'base64'

module Hollandaise
  class Project
    def initialize(project_name)
      @project_name = project_name
    end

    def root(root)
      @root = root
    end

    def port
      32516
    end

    def proxy_root(root)
      uri = URI(root)

      @userinfo = uri.userinfo
      @host = uri.host
      @port = uri.port

      @root = "http://localhost:#{port}#{uri.path}"
    end

    def with_proxy
      if !@host
        yield
      else
        proxy = Class.new(Rack::Proxy) do
          def initialize(userinfo, host, port)
            @userinfo, @host, @port = userinfo, host, port
          end

          def rewrite_env(env)
            env['HTTP_HOST'] = @host
            env['SERVER_PORT'] = @port
            env['HTTP_AUTHORIZATION'] = "Basic #{Base64.encode64(@userinfo)}"

            env
          end
        end

        server = Thread.new do
          Rack::Handler.default.run(proxy.new(@userinfo, @host, @port), :Port => port) do |server|
            Thread.current[:server] = server
          end
        end

        yield

        server[:server].stop
      end
    end

    def screenshot(name, uri)
      @screenshots ||= []

      @screenshots << [ name, uri ]
    end

    def browsers(*browsers)
      @browsers = browsers
    end

    def screen_size(size)
      @screen_size = size.split('x').collect(&:to_i)
    end

    def run
      puts "Running #{@project_name}".foreground(:green)
      with_proxy do
        urls.each do |url, name|
          puts "... #{name} (#{url})".foreground(:yellow)

          Hollandaise.chdir "#{@project_name}/#{name}" do
            browser_objects.run do |browser|
              puts "     ... #{browser.name}".foreground(:white)
              browser.run_and_take_screenshot(url, @screen_size)
            end
          end
        end
      end
    end

    private
    def urls
      @screenshots.collect do |name, uri|
        [ File.join(@root, uri), name ]
      end
    end

    def browser_objects
      @browser_objects ||= Hollandaise::Browsers.for(@browsers)
    end
  end
end

