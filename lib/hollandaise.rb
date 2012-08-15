require "hollandaise/version"
require 'hollandaise/browsers'
require 'hollandaise/browser'

module Hollandaise
  class << self
    attr_accessor :url, :browsers
  end

  def self.configure
    yield self
  end
end

