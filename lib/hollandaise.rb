require "hollandaise/version"
require 'hollandaise/browsers'
require 'hollandaise/project'
require 'hollandaise/browser'

module Hollandaise
  class << self
    attr_accessor :url, :browsers, :delay
  end

  def self.configure
    yield self
  end

  def self.project(name)
    project = Project.new(name)
    projects << project

    yield project

    project
  end

  def self.dir
    @dir ||= Pathname("screenshots")
  end

  def self.chdir(name)
    _odir = dir.clone
    @dir = @dir.join(name)

    yield

    @dir = _odir
  end

  def self.projects
    @projects ||= []
  end
end

