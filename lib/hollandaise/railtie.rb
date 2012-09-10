module Hollandaise
  class Railtie < ::Rails::Railtie
    rake_tasks do
      desc "Take screenshots from Hollandaise configuration"
      task :take_screenshots do
        Hollandaise.load_config!

        Hollandaise.projects.each(&:run)
      end
    end
  end
end
