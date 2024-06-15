# frozen_string_literal: true

require "nanoc"
module Nanoc::Tidy
  ##
  # Generic error
  Error = Class.new(RuntimeError)

  require_relative "tidy/version"
  require_relative "tidy/filter"

  ##
  # @example (see Nanoc::Tidy::Filter.default_argv)
  # @return (see Nanoc::Tidy::Filter.default_argv)
  def self.default_argv
    Filter.default_argv
  end
end
